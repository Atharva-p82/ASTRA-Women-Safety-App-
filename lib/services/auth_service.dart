// class AuthService {
//   // TODO: Integrate with real backend API
  
//   Future<bool> login(String email, String password) async {
//     try {
//       // Placeholder for API call
//       print('Login attempt: $email');
//       await Future.delayed(Duration(seconds: 1));
      
//       // TODO: Replace with actual API call
//       // final response = await http.post(
//       //   Uri.parse('${Constants.baseUrl}${Constants.loginEndpoint}'),
//       //   body: jsonEncode({'email': email, 'password': password}),
//       // );
      
//       return true;
//     } catch (e) {
//       print('Login error: $e');
//       return false;
//     }
//   }

//   Future<bool> register(String name, String email, String password) async {
//     try {
//       print('Register attempt: $email');
//       await Future.delayed(Duration(seconds: 1));
      
//       // TODO: Replace with actual API call
//       // final response = await http.post(
//       //   Uri.parse('${Constants.baseUrl}${Constants.registerEndpoint}'),
//       //   body: jsonEncode({'name': name, 'email': email, 'password': password}),
//       // );
      
//       return true;
//     } catch (e) {
//       print('Register error: $e');
//       return false;
//     }
//   }

//   Future<bool> logout() async {
//     try {
//       // TODO: Implement logout logic
//       return true;
//     } catch (e) {
//       return false;
//     }
//   }
// }



// import 'package:firebase_auth/firebase_auth.dart';

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   /// Register user with Firebase Auth
//   Future<User?> register(String name, String email, String password) async {
//     try {
//       final userCredential = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return userCredential.user;
//     } catch (e) {
//       print("Registration error: $e");
//       return null;
//     }
//   }

//   /// Login user with Firebase Auth
//   Future<User?> login(String email, String password) async {
//     try {
//       final userCredential = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return userCredential.user;
//     } catch (e) {
//       print("Login error: $e");
//       return null;
//     }
//   }

//   /// Logout user
//   Future<void> logout() async {
//     await _auth.signOut();
//   }
// }



import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> register(String name, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      if (user != null) {
        // Optional: update display name
        await user.updateDisplayName(name);
        await user.reload();
        return _auth.currentUser;
      }
      return null;
    } catch (e) {
      print('Register error: $e');
      return null;
    }
  }

  Future<User?> login(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      print('Login error: $e');
      return null;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
