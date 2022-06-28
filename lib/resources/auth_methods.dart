import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?>? get userStream {
    return _auth.authStateChanges();
  }

  User get currentUser {
    return _auth.currentUser!;
  }

  Future<void> signout() async {
    await _auth.signOut();
  }
}
