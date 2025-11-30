import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../layout/app_drawer.dart';
import '../layout/app_header.dart';
import '../providers/guardian_provider.dart';
import '../models/guardian.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  // guardians are loaded from GuardianProvider (Firestore)

  @override
  void initState() {
    super.initState();
    // _nameController.text = "John Doe";
    // _emailController.text = "johndoe@email.com";
    // _mobileController.text = "+91 9876543210";

    final user = FirebaseAuth.instance.currentUser;
    _nameController.text = user?.displayName ?? "";
    _emailController.text = user?.email ?? "";
    _mobileController.text = ""; // or fetch from Firestore if stored

    // Load guardians for this user after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final uid = user?.uid;
      if (uid != null && uid.isNotEmpty) {
        Provider.of<GuardianProvider>(context, listen: false).loadGuardians(userId: uid);
      }
    });
  }

  void _editGuardian(Guardian guardian) {
    // Navigate to edit guardian screen (if implemented)
    Navigator.pushNamed(context, '/edit_guardian', arguments: guardian);
  }

  Future<void> _deleteGuardian(String id) async {
    try {
      await Provider.of<GuardianProvider>(context, listen: false).deleteGuardian(id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Guardian removed')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to remove guardian')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppHeader(title: "Edit Profile"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.pink.shade100,
                        child: Text(
                          _nameController.text.isNotEmpty
                              ? _nameController.text[0].toUpperCase()
                              : "",
                          style: TextStyle(
                            fontSize: 42,
                            color: Colors.pink.shade400,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        decoration: const InputDecoration(labelText: "Full Name"),
                        controller: _nameController,
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        decoration: const InputDecoration(labelText: "Email"),
                        controller: _emailController,
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        decoration: const InputDecoration(labelText: "Mobile Number"),
                        controller: _mobileController,
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 18),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Profile updated!')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink.shade400,
                        ),
                        child: const Text("Save Changes"),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18, 20, 18, 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "My Guardians",
                        style: TextStyle(
                          color: Colors.pink.shade400,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Consumer<GuardianProvider>(builder: (context, gp, _) {
                        if (gp.guardians.isEmpty) return const Text("No guardians added yet.");
                        return Column(
                          children: gp.guardians.map((guardian) {
                            return Card(
                              margin: const EdgeInsets.only(bottom: 8),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.pink.shade50,
                                  foregroundColor: Colors.pink.shade400,
                                  child: Text(
                                    guardian.name.isNotEmpty ? guardian.name[0] : 'G',
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                title: Text(
                                  guardian.name,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      guardian.phone,
                                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                                    ),
                                    Text(
                                      guardian.relationship.name.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.pink.shade300,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit, color: Colors.pink.shade300),
                                      tooltip: "Edit Guardian",
                                      onPressed: () => _editGuardian(guardian),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete, color: Colors.red.shade400),
                                      tooltip: "Remove Guardian",
                                      onPressed: () => _deleteGuardian(guardian.id),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      }),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton.icon(
                          onPressed: () async {
                            final user = FirebaseAuth.instance.currentUser;
                            if (user != null) {
                              final result = await Navigator.pushNamed(
                                context,
                                '/add_guardian',
                                arguments: user.uid,
                              );
                              if (result == true && mounted) {
                                // Refresh guardians list if a guardian was added
                                Provider.of<GuardianProvider>(context, listen: false)
                                    .loadGuardians(userId: user.uid);
                              }
                            }
                          },
                          icon: Icon(Icons.person_add, color: Colors.pink.shade400),
                          label: Text(
                            "Add Guardian",
                            style: TextStyle(
                                color: Colors.pink.shade400, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
