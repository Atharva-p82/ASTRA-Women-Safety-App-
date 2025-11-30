import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FcmService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> initAndRegisterToken() async {
    // Request permission on iOS (harmless on Android)
    await _fcm.requestPermission();

    // Get token
    final token = await _fcm.getToken();
    final user = FirebaseAuth.instance.currentUser;
    if (token != null && user != null) {
      final guardianDoc = _db.collection('guardians').doc(user.uid);
      await guardianDoc.set({
        'fcmTokens': FieldValue.arrayUnion([token])
      }, SetOptions(merge: true));
    }

    // Listen for token refresh
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final guardianDoc = _db.collection('guardians').doc(user.uid);
        await guardianDoc.set({
          'fcmTokens': FieldValue.arrayUnion([newToken])
        }, SetOptions(merge: true));
      }
    });
  }

  Future<void> removeToken(String token) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final guardianDoc = _db.collection('guardians').doc(user.uid);
    await guardianDoc.update({
      'fcmTokens': FieldValue.arrayRemove([token])
    });
  }
}
