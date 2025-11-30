// import 'package:flutter/material.dart';
// import '../models/guardian.dart';
// import '../widgets/EditGuardianModal.dart';

// class EditGuardianScreen extends StatelessWidget {
//   final Guardian guardian;
//   const EditGuardianScreen({super.key, required this.guardian});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;

//     return Scaffold(
//       backgroundColor: theme.scaffoldBackgroundColor,
//       appBar: AppBar(
//         backgroundColor: theme.appBarTheme.backgroundColor ?? theme.primaryColor,
//         elevation: theme.appBarTheme.elevation ?? 2,
//         iconTheme: theme.appBarTheme.iconTheme ??
//             IconThemeData(color: theme.primaryColor),
//         title: Text(
//           'Edit Guardian',
//           style: theme.appBarTheme.titleTextStyle ??
//               TextStyle(
//                 color: isDark ? Colors.white : theme.primaryColor,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 22,
//               ),
//         ),
//         toolbarHeight: theme.appBarTheme.toolbarHeight ?? 66,
//       ),
//       body: Center(
//         child: Container(
//           constraints: BoxConstraints(maxWidth: 640),
//           decoration: BoxDecoration(
//             color: theme.cardColor.withOpacity(isDark ? 0.98 : 0.97),
//             borderRadius: BorderRadius.circular(24),
//           ),
//           margin: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
//           child: EditGuardianModal(guardian: guardian),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/guardian.dart';
import '../providers/guardian_provider.dart';

class EditGuardianScreen extends StatefulWidget {
  final Guardian guardian;
  const EditGuardianScreen({super.key, required this.guardian});

  @override
  State<EditGuardianScreen> createState() => _EditGuardianScreenState();
}

class _EditGuardianScreenState extends State<EditGuardianScreen> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late GuardianRelationship _relationship;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.guardian.name);
    _phoneController = TextEditingController(text: widget.guardian.phone);
    _emailController = TextEditingController(text: widget.guardian.email ?? '');
    _relationship = widget.guardian.relationship;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    final updatedGuardian = Guardian(
      id: widget.guardian.id,
      name: _nameController.text.trim(),
      phone: _phoneController.text.trim(),
      email: _emailController.text.trim().isEmpty ? null : _emailController.text.trim(),
      relationship: _relationship,
      createdAt: widget.guardian.createdAt,
    );

    await Provider.of<GuardianProvider>(context, listen: false).updateGuardian(updatedGuardian);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Guardian')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Guardian Name"),
            ),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: "Phone"),
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
              child: const Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }
}
