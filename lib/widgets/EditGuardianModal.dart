import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/guardian.dart';
import '../providers/guardian_provider.dart';
import 'custom_input_field.dart';
import 'custom_button.dart';
import '../utils/validators.dart';

class EditGuardianModal extends StatefulWidget {
  final Guardian guardian;

  const EditGuardianModal({
    super.key,
    required this.guardian,
  });

  @override
  State<EditGuardianModal> createState() => _EditGuardianModalState();
}

class _EditGuardianModalState extends State<EditGuardianModal> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? _nameController;
  TextEditingController? _phoneController;
  TextEditingController? _emailController;
  GuardianRelationship? _selectedRelationship;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.guardian.name);
    _phoneController = TextEditingController(text: widget.guardian.phone);
    _emailController = TextEditingController(text: widget.guardian.email ?? '');
    _selectedRelationship = widget.guardian.relationship;
  }

  @override
  void dispose() {
    _nameController?.dispose();
    _phoneController?.dispose();
    _emailController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Edit Guardian',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink.shade600,
                ),
              ),
              const SizedBox(height: 24),
              CustomInputField(
                controller: _nameController!,
                label: 'Guardian Name',
                hint: 'Enter guardian name',
                keyboardType: TextInputType.name,
                validator: Validators.validateName,
                prefixIcon: Icons.person,
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 16),
              CustomInputField(
                controller: _phoneController!,
                label: 'Phone Number',
                hint: 'Enter phone number',
                keyboardType: TextInputType.phone,
                validator: Validators.validatePhone,
                prefixIcon: Icons.phone,
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 16),
              CustomInputField(
                controller: _emailController!,
                label: 'Email (Optional)',
                hint: 'Enter email',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return null;
                  return Validators.validateEmail(value);
                },
                prefixIcon: Icons.email_outlined,
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<GuardianRelationship>(
                initialValue: _selectedRelationship,
                decoration: InputDecoration(
                  labelText: 'Relationship',
                  prefixIcon: Icon(Icons.people_outline),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.pink.shade400,
                      width: 2,
                    ),
                  ),
                ),
                items: GuardianRelationship.values
                    .map((relationship) => DropdownMenuItem(
                          value: relationship,
                          child: Text(relationship.displayName),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedRelationship = value;
                  });
                },
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      text: 'Save',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final updatedGuardian = widget.guardian.copyWith(
                            name: _nameController!.text,
                            phone: _phoneController!.text,
                            email: _emailController!.text.isEmpty ? null : _emailController!.text,
                            relationship: _selectedRelationship,
                          );
                          Provider.of<GuardianProvider>(context, listen: false)
                              .updateGuardian(updatedGuardian);
                          Navigator.pop(context);
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
