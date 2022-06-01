import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectmercury/models/contact.dart';
import 'package:projectmercury/models/transaction.dart' as model;
import 'package:projectmercury/models/user.dart' as model;
import 'package:projectmercury/resources/auth_methods.dart';
import 'package:projectmercury/resources/locator.dart';
import 'package:projectmercury/utils/global_variables.dart';

import '../models/store_item.dart';

//main firestore methods
class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  _TransactionMethods get transaction => _TransactionMethods();
  _ContactMethods get contact => _ContactMethods();
  _StoreMethods get store => _StoreMethods();
  _UserMethods get user => _UserMethods();

  Stream<List<PurchasedItem>> get itemStream => _firestore
      .collection('users')
      .doc(locator.get<AuthMethods>().currentUser.uid)
      .collection('purchased_items')
      .snapshots()
      .map((list) => list.docs
          .map((snap) => PurchasedItem.fromSnap(snap.data()))
          .toList());

  Future<void> buyItem(
    String uid,
    StoreItem storeItem,
  ) async {
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('purchased_items')
        .doc()
        .set(storeItem.toJson())
        .then((value) => debugPrint('Added item data.'))
        .onError((error, stackTrace) =>
            debugPrint('Failed to add item data: $error'));
  }

// checks if firebase document exists
  Future<bool> docExists(
      DocumentSnapshot<Map<String, dynamic>> snapshot) async {
    if (snapshot.exists) {
      return true;
    }
    return false;
  }

//checks if firebase collection exists
  Future<bool> collectionExists(
      QuerySnapshot<Map<String, dynamic>> snapshot) async {
    if (snapshot.size != 0) {
      return true;
    }
    return false;
  }
}

// firestore methods for user data
class _UserMethods extends FirestoreMethods {
  Future<void> initialize(User user) async {
    var ref = _firestore.collection('users').doc(user.uid);
    if (!(await docExists(await ref.get()))) {
      model.User userModel =
          model.User(uid: user.uid, name: user.displayName ?? 'User');
      await _firestore
          .collection('users')
          .doc(user.uid)
          .set(userModel.toJson())
          .then((value) => debugPrint('Added user data.'))
          .onError((error, stackTrace) =>
              debugPrint('Failed to add user data: $error'));
    }
    if (!(await collectionExists(
        await ref.collection('transactions').limit(1).get()))) {
      transaction.add(initialTransactions[0].id, initialTransactions[0]);
    }
  }

  Stream<DocumentSnapshot> get stream => _firestore
      .collection('users')
      .doc(locator.get<AuthMethods>().currentUser.uid)
      .snapshots();
}

// firestore methods for transaction data
class _TransactionMethods extends FirestoreMethods {
  late CollectionReference ref;
  final String userId = locator.get<AuthMethods>().currentUser.uid;
  _TransactionMethods() {
    ref = _firestore.collection('users').doc(userId).collection('transactions');
  }

  Future<void> add(
    String id,
    model.Transaction transaction,
  ) async {
    await ref
        .doc(id)
        .set(transaction.toJson())
        .then((value) => debugPrint('Added transaction data.'))
        .onError((error, stackTrace) =>
            debugPrint('Failed to add transaction data: $error'));
    _firestore
        .collection('users')
        .doc(userId)
        .update({'balance': FieldValue.increment(transaction.amount)});
  }

  Future<void> update(String id, Map<String, dynamic> values) async {
    await ref
        .doc(id)
        .update(values)
        .then((value) => debugPrint('Updated transaction data.'))
        .onError((error, stackTrace) =>
            debugPrint('Failed to update transaction data: $error'));
  }

  Stream<QuerySnapshot> get stream {
    return ref.orderBy('timeStamp', descending: true).snapshots();
  }
}

// firestore methods for store data
class _StoreMethods extends FirestoreMethods {
  late CollectionReference ref;
  _StoreMethods() {
    ref = _firestore.collection('storeItems');
  }

  Future<void> add(
    StoreItem storeItem,
  ) async {
    await ref
        .doc()
        .set(storeItem.toJson())
        .then((value) => debugPrint('Added item data.'))
        .onError((error, stackTrace) =>
            debugPrint('Failed to add item data: $error'));
  }

  Stream<QuerySnapshot> get stream {
    return ref.orderBy('type').orderBy('price').snapshots();
  }
}

// firestore methods for contact data
class _ContactMethods extends FirestoreMethods {
  late CollectionReference ref;
  _ContactMethods() {
    ref = _firestore.collection('contacts');
  }

  Future<void> add(
    Contact contact,
  ) async {
    await _firestore
        .collection('contacts')
        .doc()
        .set(contact.toJson())
        .then((value) => debugPrint('Added contact data.'))
        .onError((error, stackTrace) =>
            debugPrint('Failed to add contact data: $error'));
  }

  Stream<QuerySnapshot> get stream {
    return ref.orderBy('name').snapshots();
  }
}
