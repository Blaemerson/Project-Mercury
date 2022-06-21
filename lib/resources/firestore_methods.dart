import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectmercury/models/message.dart';
import 'package:projectmercury/models/transaction.dart' as model;
import 'package:projectmercury/models/user.dart' as model;
import 'package:projectmercury/pages/messagePage/message_data.dart';
import 'package:projectmercury/resources/auth_methods.dart';
import 'package:projectmercury/resources/event_controller.dart';
import 'package:projectmercury/resources/locator.dart';
import 'package:projectmercury/utils/global_variables.dart';

import '../models/store_item.dart';

//main firestore methods
class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  _UserTransactionMethods get userTransaction => _UserTransactionMethods();
  _UserMessageMethods get userMessage => _UserMessageMethods();
  _UserItemMethods get userItem => _UserItemMethods();
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
      userTransaction.add(initialTransaction);
    }
    if (!(await collectionExists(
        await ref.collection('messages').limit(1).get()))) {
      userMessage.add(messages[0]);
    }
    locator.get<EventController>().update();
  }

// increment user score
  Future<void> updateScore(num score) async {
    await ref
        .update({'score': FieldValue.increment(score)})
        .then((value) => debugPrint('Updated user score.'))
        .onError((error, stackTrace) =>
            debugPrint('Failed to update user score: $error'));
  }

// TODO: for testing purposes
  Future<void> reset() async {
    ref.update({'score': 0});
    ref.update({'balance': 0});
    ref.update({'session': 1});
    ref.collection('purchased_items').get().then((value) {
      for (var doc in value.docs) {
        doc.reference.delete();
      }
    });
    ref.collection('transactions').get().then((value) {
      for (var doc in value.docs) {
        doc.reference.delete();
      }
    });
    await ref.collection('messages').get().then((value) {
      for (var doc in value.docs) {
        doc.reference.delete();
      }
    });
    initialize(locator.get<AuthMethods>().currentUser);
  }

// increment user balance
  Future<void> updateBalance(num amount) async {
    await ref
        .update({'balance': FieldValue.increment(amount)})
        .then((value) => debugPrint('Updated user balance.'))
        .onError((error, stackTrace) =>
            debugPrint('Failed to update user balance: $error'));
  }

  Future<void> updateSession() async {
    await ref
        .update({'session': FieldValue.increment(1)})
        .then((value) => debugPrint('Updated user session.'))
        .onError((error, stackTrace) =>
            debugPrint('Failed to update user session: $error'));
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
    String room,
  ) async {
    await ref
        .doc()
        .set(storeItem.toJson()
          ..addAll({
            'timeBought': DateTime.now(),
            'room': room,
          }))
        .then((value) => debugPrint('Added item data.'))
        .onError((error, stackTrace) =>
            debugPrint('Failed to add item data: $error'));
    locator.get<EventController>().update();
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

  Future<bool> actionNeeded() async {
    int data = await ref
        .where('state', isEqualTo: 'actionNeeded')
        .limit(1)
        .get()
        .then((value) => value.docs.length);
    return data > 0;
  }

  Future<void> action(Message message, bool give) async {
    if (give == true) {
      userMessage.updateState(message.id, MessageState.infoGiven);
      if (message.sender.trustedWith.contains(message.requestedItem)) {
        user.updateScore(1);
      } else {
        //penalty?
      }
    } else {
      if (!message.sender.trustedWith.contains(message.requestedItem)) {
        userMessage.updateState(message.id, MessageState.infoDenied);
        user.updateScore(1);
      } else {
        //penalty?
      }
    }
    locator.get<EventController>().update();
  }

// add new message data
  Future<void> add(
    Message message,
  ) async {
    await ref
        .add(message.toJson()..addAll({'timeSent': DateTime.now()}))
        .then((doc) => doc.update({'id': doc.id}))
        .then((value) => debugPrint('Added new message.'))
        .onError(
            (error, stackTrace) => debugPrint('Failed to add new message.'));
    locator.get<EventController>().update();
  }

  Future<void> updateState(String id, MessageState state) async {
    await ref
        .doc(id)
        .update({'state': state.name, 'timeActed': DateTime.now()})
        .then((value) => debugPrint('Updated message state.'))
        .onError((error, stackTrace) =>
            debugPrint('Failed to update message state: $error'));
    await Future.delayed(
      const Duration(seconds: 1),
      () => ref.doc(id).update({'displayState': FieldValue.increment(1)}),
    );
    await Future.delayed(
      const Duration(seconds: 2),
      () => ref.doc(id).update({'displayState': FieldValue.increment(1)}),
    );
  }

// stream of messages
  Query<Message> get query =>
      ref.orderBy('timeSent', descending: true).withConverter(
          fromFirestore: (snapshot, _) => Message.fromSnap(snapshot.data()!),
          toFirestore: (message, _) => message.toJson());
}

// firestore methods for transaction data
class _UserTransactionMethods extends FirestoreMethods {
  late CollectionReference ref;
  final String userId = locator.get<AuthMethods>().currentUser.uid;
  _UserTransactionMethods() {
    ref = _firestore.collection('users').doc(userId).collection('transactions');
  }

  Future<bool> actionNeeded() async {
    int data = await ref
        .where('state', isEqualTo: 'actionNeeded')
        .limit(1)
        .get()
        .then((value) => value.docs.length);
    return data > 0;
  }

  Future<void> action(model.Transaction transaction, bool approve) async {
    if (approve == true) {
      await userTransaction.updateState(
          transaction.id, model.TransactionState.approved);
      if (transaction.overcharge == 0) {
        user.updateScore(1);
      }
    } else {
      await userTransaction.updateState(
          transaction.id, model.TransactionState.disputed);
      if (transaction.overcharge != 0) {
        userTransaction.add(
          model.Transaction(
            description: 'Refund:',
            amount: transaction.overcharge,
            state: model.TransactionState.approved,
          ),
        );
        user.updateScore(1);
      }
    }
    locator.get<EventController>().update();
  }

// add new transaction data
  Future<void> add(
    model.Transaction transaction,
  ) async {
    await ref
        .add(transaction.toJson()..addAll({'timeStamp': DateTime.now()}))
        .then((doc) => doc.update({'id': doc.id}))
        .then((value) => debugPrint('Added new transaction.'))
        .onError((error, stackTrace) =>
            debugPrint('Failed to add new transaction.'));
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
  Query<model.Transaction> get query => ref
      .orderBy('timeStamp', descending: true)
      .withConverter<model.Transaction>(
        fromFirestore: (snapshot, _) =>
            model.Transaction.fromSnap(snapshot.data()!),
        toFirestore: (transaction, _) => transaction.toJson(),
      );
}
