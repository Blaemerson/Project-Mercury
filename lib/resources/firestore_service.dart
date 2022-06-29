import 'dart:async';

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

  Future<void> deleteDocument({
    required String path,
  }) async {
    final ref = FirebaseFirestore.instance.doc(path);
    ref.delete().then((value) => debugPrint('Deleted: $path'));
  }

  Future<void> deleteCollection({
    required String path,
  }) async {
    final ref = FirebaseFirestore.instance.collection(path);
    ref.get().then((value) {
      for (var doc in value.docs) {
        doc.reference.delete();
      }
    });
  }

  Stream<T> documentStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data) builder,
  }) {
    final ref = FirebaseFirestore.instance.doc(path);
    final Stream<DocumentSnapshot> snapshots = ref.snapshots();
    return snapshots
        .map((snapshot) => builder(snapshot.data() as Map<String, dynamic>));
  }

  Stream<List<T>> collectionStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) {
    Query query = FirebaseFirestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final Stream<QuerySnapshot> snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map((snapshot) => builder(snapshot.data() as Map<String, dynamic>))
          .where((element) => element != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }
}
