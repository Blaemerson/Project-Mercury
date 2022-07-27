import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projectmercury/models/event.dart';
import 'package:projectmercury/models/transaction.dart' as model;
import 'package:projectmercury/models/user.dart' as model;
import 'package:projectmercury/resources/auth_methods.dart';
import 'package:projectmercury/resources/event_controller.dart';
import 'package:projectmercury/resources/firestore_path.dart';
import 'package:projectmercury/resources/firestore_service.dart';
import 'package:projectmercury/resources/locator.dart';
import 'package:projectmercury/utils/global_variables.dart';

import '../models/store_item.dart';

//main firestore methods
class FirestoreMethods {
  final FirestoreService _firestoreService = FirestoreService.instance;
  late StreamSubscription _userSubscription;
  model.User? lastUserData;
  late StreamSubscription _itemsSubscription;
  late StreamSubscription _eventsSubscription;
  late StreamSubscription _transactionsSubscription;

  Future<void> initializeSubscriptions() async {
    _itemsSubscription = _firestoreService
        .collectionStream(
            path: FirestorePath.items(),
            builder: (data) => PurchasedItem.fromSnap(data))
        .listen((event) {
      locator.get<EventController>().onItemsChanged(event);
    });

    _eventsSubscription = _firestoreService
        .collectionStream(
            path: FirestorePath.events(),
            builder: (data) => Event.fromSnap(data))
        .listen((event) {
      locator.get<EventController>().onEventsChanged(event);
    });

    _transactionsSubscription = _firestoreService
        .collectionStream(
            path: FirestorePath.transactions(),
            builder: (data) => model.Transaction.fromSnap(data))
        .listen((event) {
      locator.get<EventController>().onTransactionsChanged(event);
    });

    _userSubscription = _firestoreService
        .documentStream(
            path: FirestorePath.user(),
            builder: (data) => model.User.fromSnap(data))
        .listen((event) {
      if (lastUserData != null) {
        if (lastUserData!.session != event.session) {
          locator.get<EventController>().onSessionChanged(event.session);
        }
        if (lastUserData!.balance != event.balance) {
          locator.get<EventController>().onBalanceChanged(event.balance);
        }
      } else {
        locator.get<EventController>().onSessionChanged(event.session);
        locator.get<EventController>().onBalanceChanged(event.balance);
      }
      lastUserData = event;
    });
  }

  Future<void> pauseSubscriptions() async {
    _userSubscription.pause();
    _itemsSubscription.pause();
    _eventsSubscription.pause();
    _transactionsSubscription.pause();
  }

  Future<void> resumeSubscriptions() async {
    _userSubscription.resume();
    _itemsSubscription.resume();
    _eventsSubscription.resume();
    _transactionsSubscription.resume();
  }

  Future<void> cancelSubscriptions() async {
    _userSubscription.cancel();
    _itemsSubscription.cancel();
    _eventsSubscription.cancel();
    _transactionsSubscription.cancel();
  }

// initialize data
  Future<void> initializeData(User user) async {
    if (!(await _firestoreService.documentExists(path: FirestorePath.user()))) {
      model.User userModel = model.User(uid: user.uid);
      _firestoreService.addDocument(
          path: FirestorePath.users(),
          data: userModel.toJson(),
          myId: user.uid);
    }
    if (!(await _firestoreService.collectionExists(
        path: FirestorePath.transactions()))) {
      addTransaction(initialTransaction);
    }
  }

// reset data
  Future<void> resetData() async {
    pauseSubscriptions();
    _firestoreService.updateDocument(path: FirestorePath.user(), data: {
      'score': 0,
      'balance': 0,
      'session': 1,
    });
    _firestoreService.deleteCollection(path: FirestorePath.items());
    _firestoreService.deleteCollection(path: FirestorePath.transactions());
    await _firestoreService.deleteCollection(path: FirestorePath.events());
    resumeSubscriptions();
    initializeData(locator.get<AuthMethods>().currentUser);
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

// stream of user data (listen)
  Stream<model.User> get userStream => _firestoreService.documentStream(
      path: FirestorePath.user(), builder: (data) => model.User.fromSnap(data));

// add new perchased_item data
  Future<String> addItem(
    StoreItem storeItem,
    String room,
  ) async {
    String id = await _firestoreService.addDocument(
        path: FirestorePath.items(),
        data: storeItem.toJson()
          ..addAll({
            'timeBought': DateTime.now(),
            'room': room,
            'delivered': false,
          }));
    return id;
  }

  // stream of purchased_item
  Stream<PurchasedItem> itemStream({required String id}) =>
      _firestoreService.documentStream(
        path: FirestorePath.item(id),
        builder: (data) => PurchasedItem.fromSnap(data),
      );

// stream of purchased_items
  Stream<List<PurchasedItem>> itemsStream({String? room}) =>
      _firestoreService.collectionStream(
        path: FirestorePath.items(),
        builder: (data) => PurchasedItem.fromSnap(data),
        queryBuilder: (query) =>
            room != null ? query.where('room', isEqualTo: room) : query,
      );

  Future<void> addEvent(Event event) async {
    await _firestoreService.addDocument(
        path: FirestorePath.events(),
        data: event.toJson()..addAll({'timeSent': DateTime.now()}));
  }

  Future<void> eventAction(Event event, bool approve) async {
    if (approve == true) {
      updateEventState(event.id, EventState.approved);
      if (!event.isScam!) {
        updateScore(1);
      } else {
        //penalty?
      }
    } else {
      updateEventState(event.id, EventState.rejected);
      if (event.isScam!) {
        updateScore(1);
      } else {
        //penalty?
      }
    }
    List<model.Transaction> pending =
        locator.get<EventController>().pendingTransactions;
    for (model.Transaction transaction in pending) {
      updateTransactionState(
          transaction.id, model.TransactionState.actionNeeded);
      _firestoreService.updateDocument(
          path: FirestorePath.transaction(transaction.id),
          data: {'hidden': false});
      updateBalance(transaction.amount);
    }
  }

  Future<void> updateEventState(String id, EventState state) async {
    await _firestoreService.updateDocument(
      path: FirestorePath.event(id),
      data: {'state': state.name, 'timeActed': DateTime.now()},
    );
  }

  Future<void> transactionAction(
      model.Transaction transaction, bool approve) async {
    // get clone of double transaction
    model.Transaction? clone =
        locator.get<EventController>().getTransaction(transaction.cloneId);
    // deliver linked item
    if (transaction.linkedItemId != null) {
      if (clone == null) {
        _firestoreService.updateDocument(
          path: FirestorePath.item(transaction.linkedItemId!),
          data: {'delivered': true},
        );
      } else {
        if (clone.state != model.TransactionState.actionNeeded) {
          _firestoreService.updateDocument(
            path: FirestorePath.item(transaction.linkedItemId!),
            data: {'delivered': true},
          );
        }
      }
    }
    // update transaction state
    if (approve == true) {
      await updateTransactionState(
          transaction.id, model.TransactionState.approved);
      if (clone == null) {
        if (!transaction.isScam) {
          updateScore(1);
        }
      } else {
        if (clone.state == model.TransactionState.disputed) {
          updateScore(1);
        }
      }
    } else {
      await updateTransactionState(
          transaction.id, model.TransactionState.disputed);
      if (clone == null) {
        if (transaction.isScam) {
          updateScore(1);
        }
      } else {
        if (clone.state != model.TransactionState.disputed) {
          addTransaction(
            model.Transaction(
              description: 'Double Charge Refund',
              amount: -transaction.amount,
              state: model.TransactionState.pending,
            ),
            approveWithDelay: true,
          );
          clone.state == model.TransactionState.approved
              ? updateScore(1)
              : null;
        }
      }
      for (model.Transaction sub in transaction.deployOnDispute) {
        if (sub.state == model.TransactionState.pending) {
          addTransaction(sub, approveWithDelay: true);
        } else {
          addTransaction(sub);
        }
      }
    }
    for (model.Transaction sub in transaction.deployOnResolved) {
      if (sub.state == model.TransactionState.pending) {
        addTransaction(sub, approveWithDelay: true);
      } else {
        addTransaction(sub);
      }
    }
  }

// add new transaction data
  Future<void> addTransaction(
    model.Transaction transaction, {
    bool double = false,
    bool approveWithDelay = false, // use for refunds/deposits
  }) async {
    String first;
    String second;
    first = await _firestoreService.addDocument(
        path: FirestorePath.transactions(),
        data: transaction.toJson()..addAll({'timeStamp': DateTime.now()}));
    transaction.state != model.TransactionState.pending
        ? updateBalance(transaction.amount)
        : null;
    approveWithDelay
        ? Future.delayed(const Duration(seconds: 1), () {
            updateBalance(transaction.amount);
            updateTransactionState(first, model.TransactionState.approved);
          })
        : null;
    if (double) {
      second = await _firestoreService.addDocument(
          path: FirestorePath.transactions(),
          data: transaction.toJson()
            ..addAll({
              'timeStamp': DateTime.now(),
              'cloneId': first,
              'hidden': transaction.state == model.TransactionState.pending
                  ? true
                  : false,
            }));
      transaction.state != model.TransactionState.pending
          ? updateBalance(transaction.amount)
          : null;
      _firestoreService.updateDocument(
        path: FirestorePath.transaction(first),
        data: {'cloneId': second},
      );
    }
  }

// update state of transaction
  Future<void> updateTransactionState(
      String id, model.TransactionState state) async {
    await _firestoreService.updateDocument(
        path: FirestorePath.transaction(id),
        data: {'state': state.name, 'timeActed': DateTime.now()});
  }
}
