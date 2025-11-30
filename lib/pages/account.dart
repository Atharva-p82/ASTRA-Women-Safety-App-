import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../layout/app_header.dart';
import '../layout/app_drawer.dart';
import '../providers/user_provider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  // local controllers — values come from UserProvider when available
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  bool editing = false;
  @override
  void initState() {
    super.initState();
    // controllers will be populated in build using Provider
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppHeader(
        title: 'Profile & Settings',
      ),
      body: SingleChildScrollView(
        child: Consumer<UserProvider>(builder: (context, userProvider, _) {
          final userName = userProvider.userName ?? 'John Doe';
          final userEmail = userProvider.userEmail ?? 'johndoe@email.com';

          // populate controllers if not editing
          if (!editing) {
            _nameController.text = userName;
            _emailController.text = userEmail;
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.pink.shade100,
                      child: Text(
                        (userName.isNotEmpty ? userName[0] : 'J').toUpperCase(),
                        style: TextStyle(
                          fontSize: 44,
                          color: Colors.pink.shade400,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 18),
                    editing
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Column(
                              children: [
                                TextField(
                                  controller: _nameController,
                                  decoration: InputDecoration(labelText: "Name"),
                                ),
                                SizedBox(height: 12),
                                TextField(
                                  controller: _emailController,
                                  decoration: InputDecoration(labelText: "Email"),
                                ),
                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        // Save to provider
                                        final newName = _nameController.text.trim();
                                        final newEmail = _emailController.text.trim();
                                        if (userProvider.userId != null) {
                                          // Update Firestore users/{uid} document as well as provider
                                          try {
                                            await FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(userProvider.userId!)
                                                .update({
                                              'name': newName,
                                              'email': newEmail,
                                            });
                                          } catch (e) {
                                            // If update fails (doc may not exist), try set
                                            await FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(userProvider.userId!)
                                                .set({
                                              'name': newName,
                                              'email': newEmail,
                                              'updatedAt': FieldValue.serverTimestamp(),
                                            }, SetOptions(merge: true));
                                          }

                                          userProvider.setUser(
                                            userId: userProvider.userId!,
                                            name: newName,
                                            email: newEmail,
                                          );
                                        } else {
                                          userProvider.updateProfile(
                                            name: newName,
                                          );
                                        }
                                        setState(() {
                                          editing = false;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.pink.shade400,
                                      ),
                                      child: Text("Save"),
                                    ),
                                    SizedBox(width: 20),
                                    OutlinedButton(
                                      onPressed: () {
                                        setState(() {
                                          editing = false;
                                          _nameController.text = userName;
                                          _emailController.text = userEmail;
                                        });
                                      },
                                      child: Text("Cancel"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : Column(
                            children: [
                              Text(
                                userName,
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                userEmail,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              SizedBox(height: 10),
                              ElevatedButton.icon(
                                onPressed: () {
                                  setState(() => editing = true);
                                },
                                icon: Icon(Icons.edit, color: Colors.white),
                                label: Text("Edit Profile"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.pink.shade400,
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.person, color: Colors.blue),
                    title: Text("Profile"),
                    trailing: Icon(Icons.arrow_forward_ios, size: 18),
                    onTap: () => Navigator.pushNamed(context, '/profile'),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.settings, color: Colors.pink.shade400),
                    title: Text("Settings & Privacy"),
                    trailing: Icon(Icons.arrow_forward_ios, size: 18),
                    onTap: () => Navigator.pushNamed(context, '/privacy'),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.red.shade300),
                    title: Text("Logout"),
                    onTap: () =>
                        Navigator.pushReplacementNamed(context, '/login'),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    ),
  );
  }
}
