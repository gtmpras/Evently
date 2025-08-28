import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/core/routing/route_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  /// Sign in with Google
  Future<bool> signInWithGoogle() async {
    try {
      final gUser = await GoogleSignIn().signIn();
      if (gUser == null) return false;

      final gAuth = await gUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'displayname': user.displayName ?? "Anonymous",
          'email': user.email ?? "",
          'createdAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
        return true;
      }
    } catch (e) {
      print("Google sign-in error: $e");
    }
    return false;
  }

  /// Get current Firebase UID
  String? get currentUserUid => _auth.currentUser?.uid;

  /// Sign out
  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
    context.go(AppRoutes.login);
  }
}
