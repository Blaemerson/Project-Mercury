import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInAnonymously() async {
    try {
      await _auth.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future<String> login(String email, String password) async {
    String res = 'success';
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (res) {
      return res.message.toString();
    } catch (res) {
      return res.toString();
    }
    return res;
  }

  Future<String> signup(
      String email, String password, String displayName) async {
    String res = 'success';
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await cred.user!.updateDisplayName(displayName);
    } on FirebaseAuthException catch (res) {
      return res.message.toString();
    } catch (res) {
      return res.toString();
    }
    return res;
  }

  Future<void> signout() async {
    await _auth.signOut();
  }
}
