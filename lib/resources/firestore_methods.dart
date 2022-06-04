import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectmercury/models/contact.dart';
import 'package:projectmercury/models/message.dart';
import 'package:projectmercury/models/transaction.dart' as model;
import 'package:projectmercury/models/user.dart' as model;
import 'package:projectmercury/resources/auth_methods.dart';
import 'package:projectmercury/resources/locator.dart';
import 'package:projectmercury/utils/global_variables.dart';

import '../models/store_item.dart';

//main firestore methods
class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  _UserTransactionMethods get userTransaction => _UserTransactionMethods();
  _UserMessageMethods get userMessage => _UserMessageMethods();
  _UserItemMethods get userItem => _UserItemMethods();
  _ContactMethods get contact => _ContactMethods();
  _StoreMethods get store => _StoreMethods();
  _UserMethods get user => _UserMethods();

// checks if firebase document exists
  Future<bool> docExists(DocumentSnapshot snapshot) async {
    if (snapshot.exists) {
      return true;
    }
    return false;
  }

//checks if firebase collection exists
  Future<bool> collectionExists(QuerySnapshot snapshot) async {
    if (snapshot.size != 0) {
      return true;
    }
    return false;
  }
}

// firestore methods for user data
class _UserMethods extends FirestoreMethods {
  late DocumentReference ref;
  _UserMethods() {
    ref = _firestore
        .collection('users')
        .doc(locator.get<AuthMethods>().currentUser.uid);
  }

// add new users to firestore
  Future<void> initialize(User user) async {
    if (!(await docExists(await ref.get()))) {
      model.User userModel =
          model.User(uid: user.uid, name: user.displayName ?? 'User');
      await ref
          .set(userModel.toJson())
          .then((value) => debugPrint('Added new user.'))
          .onError((error, stackTrace) =>
              debugPrint('Failed to add new user: $error'));
    }
    if (!(await collectionExists(
        await ref.collection('transactions').limit(1).get()))) {
      userTransaction.add(initialTransactions[0].id, initialTransactions[0]);
    }
    if (!(await collectionExists(
        await ref.collection('messages').limit(1).get()))) {
      userMessage.add(initialMessages[0].id, initialMessages[0]);
    }
  }

// increment user score
  Future<void> updateScore(num score) async {
    await ref
        .update({'score': FieldValue.increment(score)})
        .then((value) => debugPrint('Updated user score.'))
        .onError((error, stackTrace) =>
            debugPrint('Failed to update user score: $error'));
  }

// increment user balance
  Future<void> updateBalance(num amount) async {
    await ref
        .update({'balance': FieldValue.increment(amount)})
        .then((value) => debugPrint('Updated user balance.'))
        .onError((error, stackTrace) =>
            debugPrint('Failed to update user balance: $error'));
  }

// get user model (one time read)
  Future<model.User> get getUser => ref
      .get()
      .then((snap) => model.User.fromSnap(snap.data() as Map<String, dynamic>));

// get user field (one time read)
  Future<num> get getBalance => getUser.then((value) => value.balance);

// stream of user data (listen)
  Stream<DocumentSnapshot> get stream => ref.snapshots();
}

// firestore methods for item data
class _UserItemMethods extends FirestoreMethods {
  late CollectionReference ref;
  final String userId = locator.get<AuthMethods>().currentUser.uid;
  _UserItemMethods() {
    ref = _firestore
        .collection('users')
        .doc(userId)
        .collection('purchased_items');
  }

// add new perchased_item data
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

// stream of purchased_items
  Stream<List<PurchasedItem>> get stream => ref.snapshots().map((list) => list
      .docs
      .map(
          (snap) => PurchasedItem.fromSnap(snap.data() as Map<String, dynamic>))
      .toList());
}

// firestore methods for message data
class _UserMessageMethods extends FirestoreMethods {
  late CollectionReference ref;
  final String userId = locator.get<AuthMethods>().currentUser.uid;
  _UserMessageMethods() {
    ref = _firestore.collection('users').doc(userId).collection('messages');
  }

// add new message data
  Future<void> add(
    String id,
    Message message,
  ) async {
    await ref
        .doc(id)
        .set(message.toJson())
        .then((value) => debugPrint('Added new message.'))
        .onError((error, stackTrace) =>
            debugPrint('Failed to add new message: $error'));
  }

// stream of messages
  Stream<List<Message>> get stream => ref.snapshots().map((list) => list.docs
      .map((snap) => Message.fromSnap(snap.data() as Map<String, dynamic>))
      .toList());
}

// firestore methods for transaction data
class _UserTransactionMethods extends FirestoreMethods {
  late CollectionReference ref;
  final String userId = locator.get<AuthMethods>().currentUser.uid;
  _UserTransactionMethods() {
    ref = _firestore.collection('users').doc(userId).collection('transactions');
  }

// add new transaction data
  Future<void> add(
    String id,
    model.Transaction transaction,
  ) async {
    await ref
        .doc(id)
        .set(transaction.toJson())
        .then((value) => debugPrint('Added new transaction.'))
        .onError((error, stackTrace) =>
            debugPrint('Failed to add new transaction: $error'));
    user.updateBalance(transaction.amount);
  }

// update state of transaction
  Future<void> updateState(String id, model.TransactionState state) async {
    await ref
        .doc(id)
        .update({'state': state.name, 'timeActed': DateTime.now()})
        .then((value) => debugPrint('Updated transaction state.'))
        .onError((error, stackTrace) =>
            debugPrint('Failed to update transaction state: $error'));
  }

// stream of transacitons
  Stream<List<model.Transaction>> get stream {
    return ref.orderBy('timeStamp', descending: true).snapshots().map((list) =>
        list
            .docs
            .map((snap) =>
                model.Transaction.fromSnap(snap.data() as Map<String, dynamic>))
            .toList());
  }
}

// firestore methods for store data
class _StoreMethods extends FirestoreMethods {
  late CollectionReference ref;
  _StoreMethods() {
    ref = _firestore.collection('storeItems');
  }

// add new item available to store
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

// stram of store items
  Stream<List<StoreItem>> get stream {
    return ref.orderBy('type').orderBy('price').snapshots().map((list) => list
        .docs
        .map((snap) => StoreItem.fromSnap(snap.data() as Map<String, dynamic>))
        .toList());
  }
}

// firestore methods for contact data
class _ContactMethods extends FirestoreMethods {
  late CollectionReference ref;
  _ContactMethods() {
    ref = _firestore.collection('contacts');
  }

// add new contact data
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

// stream of contacts
  Stream<List<Contact>> get stream {
    return ref.orderBy('name').snapshots().map((list) => list.docs
        .map((snap) => Contact.fromSnap(snap.data() as Map<String, dynamic>))
        .toList());
  }
}
