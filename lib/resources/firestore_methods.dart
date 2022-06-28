import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectmercury/models/message.dart';
import 'package:projectmercury/models/transaction.dart' as model;
import 'package:projectmercury/models/user.dart' as model;
import 'package:projectmercury/pages/messagePage/message_data.dart';
import 'package:projectmercury/resources/auth_methods.dart';
import 'package:projectmercury/resources/event_controller.dart';
import 'package:projectmercury/resources/firestore_path.dart';
import 'package:projectmercury/resources/firestore_service.dart';
import 'package:projectmercury/resources/locator.dart';
import 'package:projectmercury/utils/global_variables.dart';

import '../models/store_item.dart';

//main firestore methods
class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirestoreService _firestoreService = FirestoreService.instance;

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
  late DocumentReference ref = _firestore.doc(FirestorePath.user());

// add new users to firestore
  Future<void> initialize(User user) async {
    if (!(await docExists(await ref.get()))) {
      model.User userModel = model.User(uid: user.uid);
      await _firestoreService.addToCollection(
          path: FirestorePath.users(),
          data: userModel.toJson(),
          myId: user.uid);
    }
    if (!(await collectionExists(await _firestore
        .collection(FirestorePath.transactions())
        .limit(1)
        .get()))) {
      userTransaction.add(initialTransaction);
    }
    if (!(await collectionExists(await _firestore
        .collection(FirestorePath.messages())
        .limit(1)
        .get()))) {
      userMessage.add(messages[0]);
    }
    locator.get<EventController>().update();
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

// update user score
  Future<void> updateScore(num score) async {
    await _firestoreService.updateDocument(
        path: FirestorePath.user(),
        data: {'score': FieldValue.increment(score)});
  }

// update user balance
  Future<void> updateBalance(num amount) async {
    await _firestoreService.updateDocument(
        path: FirestorePath.user(),
        data: {'balance': FieldValue.increment(amount)});
  }

// update user session
  Future<void> updateSession() async {
    await _firestoreService.updateDocument(
        path: FirestorePath.user(), data: {'session': FieldValue.increment(1)});
  }

// get user model (one time read)
  Future<model.User> get getUser => ref
      .get()
      .then((snap) => model.User.fromSnap(snap.data() as Map<String, dynamic>));

// get user field (one time read)
  Future<num> get getBalance => getUser.then((value) => value.balance);
  Future<int> get getSession => getUser.then((value) => value.session);

// stream of user data (listen)
  Stream<DocumentSnapshot> get stream => ref.snapshots();
}

// firestore methods for item data
class _UserItemMethods extends FirestoreMethods {
  late CollectionReference ref = _firestore.collection(FirestorePath.items());

// add new perchased_item data
  Future<void> add(
    StoreItem storeItem,
    String room,
  ) async {
    await _firestoreService.addToCollection(
        path: FirestorePath.items(),
        data: storeItem.toJson()
          ..addAll({
            'timeBought': DateTime.now(),
            'room': room,
          }));
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
  late CollectionReference ref =
      _firestore.collection(FirestorePath.messages());

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
    await _firestoreService.addToCollection(
        path: FirestorePath.messages(),
        data: message.toJson()..addAll({'timeSent': DateTime.now()}));
    locator.get<EventController>().update();
  }

  Future<void> updateState(String id, MessageState state) async {
    await _firestoreService.updateDocument(
        path: FirestorePath.message(id),
        data: {'state': state.name, 'timeActed': DateTime.now()});
    await Future.delayed(
      const Duration(seconds: 1),
      () => _firestoreService.updateDocument(
          path: FirestorePath.message(id),
          data: {'displayState': FieldValue.increment(1)}),
    );
    await Future.delayed(
      const Duration(seconds: 2),
      () => _firestoreService.updateDocument(
          path: FirestorePath.message(id),
          data: {'displayState': FieldValue.increment(1)}),
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
  late CollectionReference ref =
      _firestore.collection(FirestorePath.transactions());

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
    await _firestoreService.addToCollection(
        path: FirestorePath.transactions(),
        data: transaction.toJson()..addAll({'timeStamp': DateTime.now()}));
    user.updateBalance(transaction.amount);
  }

// update state of transaction
  Future<void> updateState(String id, model.TransactionState state) async {
    await _firestoreService.updateDocument(
        path: FirestorePath.transaction(id),
        data: {'state': state.name, 'timeActed': DateTime.now()});
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
