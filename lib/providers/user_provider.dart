// import 'package:flutter/material.dart';

// class UserProvider with ChangeNotifier {
//   String? _userName;
//   String? _userEmail;

//   String? get userName => _userName;
//   String? get userEmail => _userEmail;

//   Null get userPhone => null;

//   void setUser(String name, String email, {required String phone}) {
//     _userName = name;
//     _userEmail = email;
//     notifyListeners();
//   }

//   void clearUser() {
//     _userName = null;
//     _userEmail = null;
//     notifyListeners();
//   }

//   void updateProfile({required String name, required String phone}) {}
// }



import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String? _userId;
  String? _userName;
  String? _userEmail;
  String? _userPhone;

  String? get userId => _userId;
  String? get userName => _userName;
  String? get userEmail => _userEmail;
  String? get userPhone => _userPhone;

  void setUser({
    required String userId,
    required String name,
    required String email,
    String? phone,
  }) {
    _userId = userId;
    _userName = name;
    _userEmail = email;
    _userPhone = phone;
    notifyListeners();
  }

  void updateProfile({required String name, String? phone}) {
    _userName = name;
    if (phone != null) _userPhone = phone;
    notifyListeners();
  }

  void clearUser() {
    _userId = null;
    _userName = null;
    _userEmail = null;
    _userPhone = null;
    notifyListeners();
  }
}

