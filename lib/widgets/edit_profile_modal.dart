import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import 'custom_input_field.dart';
import 'custom_button.dart';
import '../utils/validators.dart';

/// A dialog that allows editing the current user's name and phone number.
class EditProfileModal extends StatefulWidget {
  const EditProfileModal({super.key});

  @override
  State<EditProfileModal> createState() => _EditProfileModalState();
}

class _EditProfileModalState extends State<EditProfileModal> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    _nameController = TextEditingController(text: userProvider.userName ?? '');
    _phoneController = TextEditingController(text: userProvider.userPhone ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use listen: false for reading initial values and to avoid rebuild loops.
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink.shade600,
                ),
              ),
              const SizedBox(height: 24),
              CustomInputField(
                controller: _nameController,
                label: 'Full Name',
                hint: 'Enter your name',
                keyboardType: TextInputType.name,
                validator: Validators.validateName,
                prefixIcon: Icons.person,
                style: const TextStyle(),
              ),
              const SizedBox(height: 16),
              CustomInputField(
                controller: _phoneController,
                label: 'Phone Number',
                hint: 'Enter your phone',
                keyboardType: TextInputType.phone,
                validator: Validators.validatePhone,
                prefixIcon: Icons.phone,
                style: const TextStyle(),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      text: 'Save',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          userProvider.updateProfile(
                            name: _nameController.text.trim(),
                            phone: _phoneController.text.trim(),
                          );
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
