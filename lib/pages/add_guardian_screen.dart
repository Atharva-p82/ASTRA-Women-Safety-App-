// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../models/guardian.dart';

// class AddGuardianScreen extends StatefulWidget {
//   @override
//   State<AddGuardianScreen> createState() => _AddGuardianScreenState();
// }

// class _AddGuardianScreenState extends State<AddGuardianScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _emailController = TextEditingController();
//   GuardianRelationship _relationship = GuardianRelationship.friend;

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _phoneController.dispose();
//     _emailController.dispose();
//     super.dispose();
//   }

//   void _submitForm() {
//     if (!_formKey.currentState!.validate()) return;
//     final guardian = Guardian(
//       id: UniqueKey().toString(),
//       name: _nameController.text.trim(),
//       phone: _phoneController.text.trim(),
//       email: _emailController.text.trim().isEmpty
//           ? null
//           : _emailController.text.trim(),
//       relationship: _relationship,
//       createdAt: DateTime.now(),
//     );
//     // In this "unsynced" version, you must pass guardian back via Navigator or other local state!
//     Navigator.pop(context, guardian);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Add Guardian')),
//       body: Padding(
//         padding: EdgeInsets.all(20),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _nameController,
//                 decoration: InputDecoration(labelText: "Guardian Name"),
//                 validator: (v) => (v == null || v.isEmpty) ? "Required" : null,
//               ),
//               TextFormField(
//                 controller: _phoneController,
//                 decoration: InputDecoration(labelText: "Phone"),
//                 validator: (v) => (v == null || v.isEmpty) ? "Required" : null,
//               ),
//               TextFormField(
//                 controller: _emailController,
//                 decoration: InputDecoration(labelText: "Email (optional)"),
//               ),
//               DropdownButton<GuardianRelationship>(
//                 value: _relationship,
//                 items: GuardianRelationship.values
//                     .map((r) => DropdownMenuItem(
//                           child: Text(r.displayName),
//                           value: r,
//                         ))
//                     .toList(),
//                 onChanged: (r) => setState(() {
//                   if (r != null) _relationship = r;
//                 }),
//               ),
//               SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: _submitForm,
//                 child: Text("Add Guardian"),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/guardian.dart';
import '../providers/guardian_provider.dart';
import '../providers/user_provider.dart';

class AddGuardianScreen extends StatefulWidget {
  const AddGuardianScreen({super.key});

  @override
  State<AddGuardianScreen> createState() => _AddGuardianScreenState();
}

class _AddGuardianScreenState extends State<AddGuardianScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  GuardianRelationship _relationship = GuardianRelationship.friend;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    final guardian = Guardian(
      id: '', // Firestore will generate ID
      name: _nameController.text.trim(),
      phone: _phoneController.text.trim(),
      email: _emailController.text.trim().isEmpty ? null : _emailController.text.trim(),
      relationship: _relationship,
      createdAt: DateTime.now(),
    );

  final userProvider = Provider.of<UserProvider>(context, listen: false);
  await Provider.of<GuardianProvider>(context, listen: false)
    .addGuardian(guardian, ownerUserId: userProvider.userId);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Guardian')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Guardian Name"),
                validator: (v) => (v == null || v.isEmpty) ? "Required" : null,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: "Phone"),
                validator: (v) => (v == null || v.isEmpty) ? "Required" : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Email (optional)"),
              ),
              DropdownButton<GuardianRelationship>(
                value: _relationship,
                items: GuardianRelationship.values
                    .map((r) => DropdownMenuItem(
                          value: r,
                          child: Text(r.displayName),
                        ))
                    .toList(),
                onChanged: (r) => setState(() {
                  if (r != null) _relationship = r;
                }),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text("Add Guardian"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
