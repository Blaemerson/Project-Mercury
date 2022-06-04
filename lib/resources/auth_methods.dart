import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:projectmercury/resources/analytics_methods.dart';
import 'package:projectmercury/resources/firestore_methods.dart';
import 'package:projectmercury/resources/locator.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AnalyticsMethods _analytics = locator.get<AnalyticsMethods>();

  Stream<User?>? get userStream {
    return _auth.authStateChanges();
  }

  User get currentUser {
    return _auth.currentUser!;
  }

  Future<String> signInAnonymously() async {
    String res = 'success';
    try {
      UserCredential cred = await _auth.signInAnonymously();
      await _analytics.setUserProperties(cred.user!.uid);
    } on FirebaseAuthException catch (res) {
      return res.message.toString();
    }
    return res;
  }

  Future<String> signup(
    String email,
    String password,
    String displayName,
  ) async {
    String res = 'success';
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _analytics.setUserProperties(cred.user!.uid);
      await cred.user!.updateDisplayName(displayName);
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    } catch (e) {
      return e.toString();
    }
    return res;
  }

  Future<String> login(String email, String password) async {
    String res = 'success';
    try {
      UserCredential cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      await _analytics.setUserProperties(cred.user!.uid);
      await locator.get<FirestoreMethods>().user.initialize(cred.user!);
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
