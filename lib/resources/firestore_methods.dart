import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projectmercury/models/event.dart';
import 'package:projectmercury/models/transaction.dart' as model;
import 'package:projectmercury/models/user.dart' as model;
import 'package:projectmercury/pages/eventPage/event_data.dart';
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
    locator.get<EventController>().update();
  }

// reset data
  Future<void> resetData() async {
    await _firestoreService.updateDocument(path: FirestorePath.user(), data: {
      'score': 0,
      'balance': 0,
      'session': 1,
    });
    await _firestoreService.deleteCollection(path: FirestorePath.items());
    await _firestoreService.deleteCollection(
        path: FirestorePath.transactions());
    await _firestoreService.deleteCollection(path: FirestorePath.messages());
    await _firestoreService.deleteCollection(path: FirestorePath.events());
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

// get user model (one time read)
  Future<model.User> get userFuture => _firestoreService.documentFuture(
      path: FirestorePath.user(), builder: (data) => model.User.fromSnap(data));

// stream of user data (listen)
  Stream<model.User> get userStream => _firestoreService.documentStream(
      path: FirestorePath.user(), builder: (data) => model.User.fromSnap(data));

// add new perchased_item data
  Future<void> addItem(
    StoreItem storeItem,
    String room,
  ) async {
    await _firestoreService.addDocument(
        path: FirestorePath.items(),
        data: storeItem.toJson()
          ..addAll({
            'timeBought': DateTime.now(),
            'room': room,
          }));
    locator.get<EventController>().update();
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

  Future<bool> waitingEventAction() async {
    List<Event> events = await _firestoreService.collectionFuture(
        path: FirestorePath.events(),
        builder: (data) => Event.fromSnap(data),
        queryBuilder: (query) =>
            query.where('state', isEqualTo: 'actionNeeded').limit(1));
    int data = events.length;
    return data > 0;
  }

  Future<void> addEvent(Event event) async {
    await _firestoreService.addDocument(
        path: FirestorePath.events(),
        data: event.toJson()..addAll({'timeSent': DateTime.now()}));
    locator.get<EventController>().update();
  }

  Future<void> eventAction(Event event, bool approve) async {
    if (approve == true) {
      updateEventState(event.id, EventState.approved);
      if (event.correctAnswer == true) {
        updateScore(1);
      } else {
        //penalty?
      }
    } else {
      updateEventState(event.id, EventState.rejected);
      if (event.correctAnswer == false) {
        updateScore(1);
      } else {
        //penalty?
      }
    }
    locator.get<EventController>().update();
  }

  Future<void> updateEventState(String id, EventState state) async {
    await _firestoreService.updateDocument(
      path: FirestorePath.event(id),
      data: {'state': state.name, 'timeActed': DateTime.now()},
    );
  }

  Future<List<Event>> get eventsFuture => _firestoreService.collectionFuture(
        path: FirestorePath.events(),
        builder: (data) => Event.fromSnap(data),
      );

// query of events
  Query<Event> get eventQuery => _firestoreService.collectionQuery(
      path: FirestorePath.events(),
      queryBuilder: (query) => query
          .orderBy('timeSent', descending: true)
          .withConverter(
              fromFirestore: (snapshot, _) => Event.fromSnap(snapshot.data()!),
              toFirestore: (event, _) => event.toJson()));

  Future<bool> waitingTransactionAction() async {
    List<model.Transaction> transactions =
        await _firestoreService.collectionFuture(
      path: FirestorePath.transactions(),
      builder: (data) => model.Transaction.fromSnap(data),
      queryBuilder: (query) =>
          query.where('state', isEqualTo: 'actionNeeded').limit(1),
    );
    int data = transactions.length;
    return data > 0;
  }

  Future<void> transactionAction(
      model.Transaction transaction, bool approve) async {
    if (approve == true) {
      await updateTransactionState(
          transaction.id, model.TransactionState.approved);
      if (transaction.overcharge == 0) {
        updateScore(1);
      }
    } else {
      await updateTransactionState(
          transaction.id, model.TransactionState.disputed);
      if (transaction.overcharge != 0) {
        addTransaction(
          model.Transaction(
            description: 'Refund:',
            amount: transaction.overcharge,
            state: model.TransactionState.approved,
          ),
        );
        updateScore(1);
      }
    }
    locator.get<EventController>().update();
  }

// add new transaction data
  Future<void> addTransaction(
    model.Transaction transaction,
  ) async {
    await _firestoreService.addDocument(
        path: FirestorePath.transactions(),
        data: transaction.toJson()..addAll({'timeStamp': DateTime.now()}));
    updateBalance(transaction.amount);
  }

// update state of transaction
  Future<void> updateTransactionState(
      String id, model.TransactionState state) async {
    await _firestoreService.updateDocument(
        path: FirestorePath.transaction(id),
        data: {'state': state.name, 'timeActed': DateTime.now()});
  }

// query of transacitons
  Query<model.Transaction> get transactionQuery =>
      _firestoreService.collectionQuery(
        path: FirestorePath.transactions(),
        queryBuilder: (query) => query
            .orderBy('timeStamp', descending: true)
            .withConverter<model.Transaction>(
              fromFirestore: (snapshot, _) =>
                  model.Transaction.fromSnap(snapshot.data()!),
              toFirestore: (transaction, _) => transaction.toJson(),
            ),
      );
}
