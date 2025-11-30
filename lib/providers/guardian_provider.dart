// import 'package:flutter/material.dart';
// import '../models/guardian.dart';

// class GuardianProvider extends ChangeNotifier {
//   List<Guardian> _guardians = [];
//   List<Guardian> _iAmGuardianOf = [];
//   bool _loading = false;

//   List<Guardian> get guardians => _guardians;
//   List<Guardian> get iAmGuardianOf => _iAmGuardianOf;
//   bool get loading => _loading;

//   // Load guardians for the current user
//   Future<void> loadGuardians() async {
//     _loading = true;
//     notifyListeners();
//     await Future.delayed(Duration(milliseconds: 500));
//     // TODO: Replace with actual guardians from a database/API
//     _guardians = [
//       Guardian(
//         id: 'g1',
//         name: 'Rohit Sharma',
//         phone: '+919876543210',
//         email: 'rohit@email.com',
//         relationship: GuardianRelationship.friend,
//         createdAt: DateTime.now().subtract(Duration(days: 10)),
//       ),
//       Guardian(
//         id: 'g2',
//         name: 'Mira Patel',
//         phone: '+919812345678',
//         email: 'mira@email.com',
//         relationship: GuardianRelationship.relative,
//         createdAt: DateTime.now().subtract(Duration(days: 4)),
//       ),
//     ];
//     _loading = false;
//     notifyListeners();
//   }

//   // Load users for whom current user is a guardian
//   Future<void> loadIAmGuardianOf() async {
//     _loading = true;
//     notifyListeners();
//     await Future.delayed(Duration(milliseconds: 500));
//     _iAmGuardianOf = [
//       Guardian(
//         id: 'user_001',
//         name: 'Aditi Kumar',
//         phone: '+919876543210',
//         email: 'aditi@email.com',
//         relationship: GuardianRelationship.friend,
//         createdAt: DateTime.now().subtract(Duration(days: 2)),
//       ),
//       Guardian(
//         id: 'user_002',
//         name: 'Nishant Raj',
//         phone: '+919998887776',
//         email: 'nishant@email.com',
//         relationship: GuardianRelationship.other,
//         createdAt: DateTime.now().subtract(Duration(days: 1)),
//       ),
//     ];
//     _loading = false;
//     notifyListeners();
//   }

//   Future<void> addGuardian(Guardian guardian) async {
//     _guardians.add(guardian);
//     notifyListeners();
//   }

//   Future<void> updateGuardian(Guardian updated) async {
//     final index = _guardians.indexWhere((g) => g.id == updated.id);
//     if (index != -1) {
//       _guardians[index] = updated;
//       notifyListeners();
//     }
//   }

//   Future<void> deleteGuardian(String id) async {
//     _guardians.removeWhere((g) => g.id == id);
//     notifyListeners();
//   }

//   // Optional: clear all loaded data (for logout/reset)
//   void clear() {
//     _guardians.clear();
//     _iAmGuardianOf.clear();
//     _loading = false;
//     notifyListeners();
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/guardian.dart';

class GuardianProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Guardian> _guardians = [];
  List<Guardian> get guardians => _guardians;

  final String _collectionPath = 'guardians'; // Firestore collection

  // Load guardians from Firestore. If [userId] is provided, only load guardians
  // that belong to that user (documents where 'userId' == provided id).
  Future<void> loadGuardians({String? userId}) async {
    try {
      _guardians = [];
      final List<Guardian> loaded = [];

      if (userId != null && userId.isNotEmpty) {
        // 1) Try loading from users/{uid}/guardians subcollection (some installs use this)
        try {
          final subSnap = await _firestore
              .collection('users')
              .doc(userId)
              .collection(_collectionPath)
              .get();
          loaded.addAll(subSnap.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>? ?? <String, dynamic>{};
            return Guardian.fromMap(data, doc.id);
          }));
        } catch (e) {
          // ignore subcollection errors and continue to top-level query
          debugPrint('No subcollection guardians for user $userId or failed to read it: $e');
        }

        // 2) Also load from top-level collection where userId field equals current user
        try {
          final topSnap = await _firestore
              .collection(_collectionPath)
              .where('userId', isEqualTo: userId)
              .get();
          loaded.addAll(topSnap.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>? ?? <String, dynamic>{};
            return Guardian.fromMap(data, doc.id);
          }));
        } catch (e) {
          debugPrint('Top-level guardians query failed for user $userId: $e');
        }
      } else {
        // No userId provided: load everything (original behaviour)
        final snapshot = await _firestore.collection(_collectionPath).get();
        loaded.addAll(snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>? ?? <String, dynamic>{};
          return Guardian.fromMap(data, doc.id);
        }));
      }

      // Deduplicate by document id (some docs may appear in both sources)
      final Map<String, Guardian> byId = {};
      for (final g in loaded) {
        if (g.id.isNotEmpty) {
          byId[g.id] = g;
        }
      }

      _guardians = byId.values.toList();
      debugPrint('Loaded ${_guardians.length} guardians for userId=${userId ?? 'all'}');
      notifyListeners();
    } catch (e) {
      debugPrint('Failed to load guardians: $e');
    }
  }

  // Add new guardian
  /// Add a guardian. Optionally provide [ownerUserId] which will be saved
  /// in the document as 'userId' so it can be queried per-user.
  Future<void> addGuardian(Guardian guardian, {String? ownerUserId}) async {
    try {
      final data = guardian.toMap();
      if (ownerUserId != null && ownerUserId.isNotEmpty) {
        data['userId'] = ownerUserId;
        // Get owner info from Firebase Auth
        final currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser != null) {
          data['ownerEmail'] = currentUser.email;
          data['ownerName'] = currentUser.displayName ?? currentUser.email?.split('@')[0];
          debugPrint('Adding guardian for user: ${data['ownerEmail']} (${data['ownerName']})');
        }
      }
      final docRef = await _firestore.collection(_collectionPath).add(data);
      _guardians.add(guardian.copyWith(id: docRef.id));
      notifyListeners();
    } catch (e) {
      debugPrint('Failed to add guardian: $e');
      rethrow;
    }
  }

  // Update guardian
  Future<void> updateGuardian(Guardian guardian) async {
    try {
      await _firestore.collection(_collectionPath).doc(guardian.id).update(guardian.toMap());
      final index = _guardians.indexWhere((g) => g.id == guardian.id);
      if (index != -1) {
        _guardians[index] = guardian;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Failed to update guardian: $e');
      rethrow;
    }
  }

  // Delete guardian
  Future<void> deleteGuardian(String id) async {
    try {
      await _firestore.collection(_collectionPath).doc(id).delete();
      _guardians.removeWhere((g) => g.id == id);
      notifyListeners();
    } catch (e) {
      debugPrint('Failed to delete guardian: $e');
      rethrow;
    }
  }

  
}
