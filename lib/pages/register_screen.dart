// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import '../providers/auth_provider.dart';
// import '../utils/validators.dart';
// import '../widgets/custom_button.dart';
// import '../widgets/custom_input_field.dart';
// import '../widgets/animated_background.dart';


// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});

//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//   bool _obscurePassword = true;
//   bool _obscureConfirmPassword = true;

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;

//     return Scaffold(
//       body: AnimatedBackground(
//         isDark: isDark,
//         child: SafeArea(
//           child: Center(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(24),
//               child: Card(
//                 elevation: 10,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 color: theme.cardColor,
//                 child: Container(
//                   padding: const EdgeInsets.all(32),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: theme.cardColor.withOpacity(isDark ? 0.96 : 0.95),
//                   ),
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         // Only the logo, no circle/gradient
//                         Padding(
//                           padding: const EdgeInsets.only(bottom: 12.0),
//                           child: Image.asset(
//                             'lib/assets/images/logo.png',
//                             width: 76,
//                             height: 76,
//                             fit: BoxFit.contain,
//                           ),
//                         ),
//                         const SizedBox(height: 26),
//                         Text(
//                           "Join SafeHer",
//                           style: GoogleFonts.montserrat(
//                             fontSize: 32,
//                             fontWeight: FontWeight.w900,
//                             color: isDark ? Colors.white : Colors.black,
//                           ),
//                         ),
//                         const SizedBox(height: 12),
//                         Text(
//                           "Create your account for safety",
//                           style: GoogleFonts.montserrat(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: isDark ? Colors.white70 : Colors.black87,
//                           ),
//                         ),
//                         const SizedBox(height: 36),
//                         CustomInputField(
//                           controller: _nameController,
//                           label: "Full Name",
//                           hint: "Enter your full name",
//                           keyboardType: TextInputType.name,
//                           validator: Validators.validateName,
//                           prefixIcon: Icons.person_outline,
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18,
//                             color: isDark ? Colors.white : Colors.black,
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         CustomInputField(
//                           controller: _emailController,
//                           label: "Email",
//                           hint: "Enter your email",
//                           keyboardType: TextInputType.emailAddress,
//                           validator: Validators.validateEmail,
//                           prefixIcon: Icons.email_outlined,
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18,
//                             color: isDark ? Colors.white : Colors.black,
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         TextFormField(
//                           controller: _passwordController,
//                           obscureText: _obscurePassword,
//                           style: TextStyle(
//                             color: isDark ? Colors.white : Colors.black,
//                             fontSize: 26,
//                             fontWeight: FontWeight.bold,
//                             letterSpacing: 3,
//                           ),
//                           decoration: InputDecoration(
//                             labelText: "Password",
//                             labelStyle: TextStyle(
//                               color: isDark ? Colors.white70 : Colors.black87,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18,
//                             ),
//                             hintText: "Enter your password",
//                             hintStyle: TextStyle(
//                               color: isDark ? Colors.white54 : Colors.grey.shade500,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                             ),
//                             prefixIcon: const Icon(Icons.lock_outline),
//                             suffixIcon: IconButton(
//                               icon: Icon(
//                                 _obscurePassword
//                                     ? Icons.visibility
//                                     : Icons.visibility_off,
//                                 color: theme.primaryColor,
//                               ),
//                               onPressed: () => setState(() {
//                                 _obscurePassword = !_obscurePassword;
//                               }),
//                             ),
//                             filled: true,
//                             fillColor: isDark ? theme.cardColor : Colors.grey.shade50,
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide: BorderSide.none,
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide: BorderSide(color: Colors.grey.shade300),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide: BorderSide(
//                                 color: theme.primaryColor,
//                                 width: 2,
//                               ),
//                             ),
//                           ),
//                           validator: Validators.validatePassword,
//                         ),
//                         const SizedBox(height: 16),
//                         TextFormField(
//                           controller: _confirmPasswordController,
//                           obscureText: _obscureConfirmPassword,
//                           style: TextStyle(
//                             color: isDark ? Colors.white : Colors.black,
//                             fontSize: 26,
//                             fontWeight: FontWeight.bold,
//                             letterSpacing: 3,
//                           ),
//                           decoration: InputDecoration(
//                             labelText: "Confirm Password",
//                             labelStyle: TextStyle(
//                               color: isDark ? Colors.white70 : Colors.black87,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18,
//                             ),
//                             hintText: "Confirm your password",
//                             hintStyle: TextStyle(
//                               color: isDark ? Colors.white54 : Colors.grey.shade500,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                             ),
//                             prefixIcon: const Icon(Icons.lock_outline),
//                             suffixIcon: IconButton(
//                               icon: Icon(
//                                 _obscureConfirmPassword
//                                     ? Icons.visibility
//                                     : Icons.visibility_off,
//                                 color: theme.primaryColor,
//                               ),
//                               onPressed: () => setState(() {
//                                 _obscureConfirmPassword = !_obscureConfirmPassword;
//                               }),
//                             ),
//                             filled: true,
//                             fillColor: isDark ? theme.cardColor : Colors.grey.shade50,
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide: BorderSide.none,
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide: BorderSide(color: Colors.grey.shade300),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide: BorderSide(
//                                 color: theme.primaryColor,
//                                 width: 2,
//                               ),
//                             ),
//                           ),
//                           validator: (val) => Validators.validateConfirmPassword(
//                             val,
//                             _passwordController.text,
//                           ),
//                         ),
//                         const SizedBox(height: 30),
//                         Consumer<AuthProvider>(
//                           builder: (context, auth, child) {
//                             return CustomButton(
//                               text: "Create Account",
//                               isLoading: auth.isAuthenticating,
//                               onPressed: () async {
//                                 if (_formKey.currentState!.validate()) {
//                                   final success = await auth.register(
//                                     _nameController.text,
//                                     _emailController.text,
//                                     _passwordController.text,
//                                   );
//                                   if (success) {
//                                     Navigator.pushReplacementNamed(
//                                       context,
//                                       '/main_layout',
//                                     );
//                                   }
//                                 }
//                               },
//                             );
//                           },
//                         ),
//                         const SizedBox(height: 18),
//                         TextButton(
//                           onPressed: () => Navigator.pop(context),
//                           child: Text(
//                             "Already have an account? Sign In",
//                             style: TextStyle(
//                               color: theme.primaryColor,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import '../providers/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../utils/validators.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input_field.dart';
import '../widgets/animated_background.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  /// Handles registration process
  Future<void> _registerUser(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      // Use AuthProvider to register user
      final success = await authProvider.register(
        _nameController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (success && authProvider.user != null) {
        final user = authProvider.user!;

        // Save user info to Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': _nameController.text.trim(),
          'email': _emailController.text.trim(),
          'phone': '', // optional
          'createdAt': FieldValue.serverTimestamp(),
        });

        // Update UserProvider
        userProvider.setUser(
          userId: user.uid,
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
        );

        // Navigate to main layout
        Navigator.pushReplacementNamed(context, '/main_layout');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authProvider.errorMessage ?? 'Registration failed'),
            backgroundColor: Colors.red.shade400,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration failed: $e'),
          backgroundColor: Colors.red.shade400,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: AnimatedBackground(
        isDark: isDark,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: theme.cardColor,
                child: Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: theme.cardColor.withOpacity(isDark ? 0.96 : 0.95),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Image.asset(
                            'lib/assets/images/logo.png',
                            width: 76,
                            height: 76,
                          ),
                        ),
                        const SizedBox(height: 26),
                        Text(
                          "Join SafeHer",
                          style: GoogleFonts.montserrat(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Create your account for safety",
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white70 : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 36),
                        CustomInputField(
                          controller: _nameController,
                          label: "Full Name",
                          hint: "Enter your full name",
                          keyboardType: TextInputType.name,
                          validator: Validators.validateName,
                          prefixIcon: Icons.person_outline,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 16),
                        CustomInputField(
                          controller: _emailController,
                          label: "Email",
                          hint: "Enter your email",
                          keyboardType: TextInputType.emailAddress,
                          validator: Validators.validateEmail,
                          prefixIcon: Icons.email_outlined,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3,
                          ),
                          decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: theme.primaryColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            filled: true,
                            fillColor:
                                isDark ? theme.cardColor : Colors.grey.shade50,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: Validators.validatePassword,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: _obscureConfirmPassword,
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3,
                          ),
                          decoration: InputDecoration(
                            labelText: "Confirm Password",
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureConfirmPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: theme.primaryColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPassword =
                                      !_obscureConfirmPassword;
                                });
                              },
                            ),
                            filled: true,
                            fillColor:
                                isDark ? theme.cardColor : Colors.grey.shade50,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (val) => Validators.validateConfirmPassword(
                              val, _passwordController.text),
                        ),
                        const SizedBox(height: 30),
                        Consumer<AuthProvider>(
                          builder: (context, auth, child) {
                            return CustomButton(
                              text: "Create Account",
                              isLoading: auth.isAuthenticating,
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await _registerUser(context);
                                }
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 18),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            "Already have an account? Sign In",
                            style: TextStyle(
                              color: theme.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
