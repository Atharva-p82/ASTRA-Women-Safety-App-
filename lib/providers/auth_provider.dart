// import 'package:flutter/material.dart';
// import '../services/auth_service.dart';

// class AuthProvider extends ChangeNotifier {
//   final AuthService _authService = AuthService();
  
//   bool _isAuthenticating = false;
//   String? _errorMessage;
//   bool _isAuthenticated = false;

//   bool get isAuthenticating => _isAuthenticating;
//   String? get errorMessage => _errorMessage;
//   bool get isAuthenticated => _isAuthenticated;

//   Future<bool> login(String email, String password) async {
//     _isAuthenticating = true;
//     _errorMessage = null;
//     notifyListeners();

//     try {
//       final success = await _authService.login(email, password);
//       if (success) {
//         _isAuthenticated = true;
//         _errorMessage = null;
//       } else {
//         _errorMessage = 'Invalid credentials';
//         _isAuthenticated = false;
//       }
//     } catch (e) {
//       _errorMessage = e.toString();
//       _isAuthenticated = false;
//     }

//     _isAuthenticating = false;
//     notifyListeners();
//     return _isAuthenticated;
//   }

//   Future<bool> register(
//     String name,
//     String email,
//     String password,
//   ) async {
//     _isAuthenticating = true;
//     _errorMessage = null;
//     notifyListeners();

//     try {
//       final success =
//           await _authService.register(name, email, password);
//       if (success) {
//         _isAuthenticated = true;
//         _errorMessage = null;
//       } else {
//         _errorMessage = 'Registration failed';
//         _isAuthenticated = false;
//       }
//     } catch (e) {
//       _errorMessage = e.toString();
//       _isAuthenticated = false;
//     }

//     _isAuthenticating = false;
//     notifyListeners();
//     return _isAuthenticated;
//   }

//   Future<void> logout() async {
//     _isAuthenticated = false;
//     _errorMessage = null;
//     notifyListeners();
//   }

//   void clearError() {
//     _errorMessage = null;
//     notifyListeners();
//   }
// }



// import 'package:flutter/material.dart';
// import '../services/auth_service.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class AuthProvider extends ChangeNotifier {
//   final AuthService _authService = AuthService();

//   bool _isAuthenticating = false;
//   String? _errorMessage;
//   User? _user;

//   bool get isAuthenticating => _isAuthenticating;
//   String? get errorMessage => _errorMessage;
//   User? get user => _user;

//   Future<bool> register(String name, String email, String password) async {
//     _isAuthenticating = true;
//     _errorMessage = null;
//     notifyListeners();

//     final user = await _authService.register(name, email, password);

//     if (user != null) {
//       _user = user;
//       _isAuthenticating = false;
//       notifyListeners();
//       return true;
//     } else {
//       _errorMessage = "Registration failed";
//       _isAuthenticating = false;
//       notifyListeners();
//       return false;
//     }
//   }

//   Future<bool> login(String email, String password) async {
//     _isAuthenticating = true;
//     _errorMessage = null;
//     notifyListeners();

//     final user = await _authService.login(email, password);

//     if (user != null) {
//       _user = user;
//       _isAuthenticating = false;
//       notifyListeners();
//       return true;
//     } else {
//       _errorMessage = "Login failed";
//       _isAuthenticating = false;
//       notifyListeners();
//       return false;
//     }
//   }

//   Future<void> logout() async {
//     await _authService.logout();
//     _user = null;
//     notifyListeners();
//   }
// }



import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isAuthenticating = false;
  String? _errorMessage;
  User? _user;

  bool get isAuthenticating => _isAuthenticating;
  String? get errorMessage => _errorMessage;
  User? get user => _user;

  // Register with Firebase
  Future<bool> register(String name, String email, String password) async {
    _isAuthenticating = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      _user = credential.user;

      _isAuthenticating = false;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message;
      _isAuthenticating = false;
      notifyListeners();
      return false;
    }
  }

  // Login with Firebase
  Future<bool> login(String email, String password) async {
    _isAuthenticating = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final credential =
          await _auth.signInWithEmailAndPassword(email: email, password: password);

      _user = credential.user;

      _isAuthenticating = false;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message;
      _isAuthenticating = false;
      notifyListeners();
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
    _user = null;
    notifyListeners();
  }
}
