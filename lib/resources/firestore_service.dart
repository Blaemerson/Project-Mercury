import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreService {
  FirestoreService._();
  static final instance = FirestoreService._();

  Future<void> addToCollection({
    required String path,
    required Map<String, dynamic> data,
    String? myId,
  }) async {
    final ref = FirebaseFirestore.instance.collection(path);
    myId == null
        ? await ref
            .add(data)
            .then((doc) => doc.update({'id': doc.id}))
            .then((_) => debugPrint('Added to $path: $data'))
            .onError((error, stackTrace) => debugPrint('$error'))
        : await ref
            .doc(myId)
            .set(data)
            .then((_) => debugPrint('Added to $path: $data'))
            .onError((error, stackTrace) => debugPrint('$error'));
  }

  Future<void> updateDocument({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final ref = FirebaseFirestore.instance.doc(path);
    await ref
        .update(data)
        .then((_) => debugPrint('Updated $path: $data'))
        .onError((error, stackTrace) => debugPrint('$error'));
  }
}
