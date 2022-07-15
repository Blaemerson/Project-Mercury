import 'package:flutter/cupertino.dart';
import 'package:projectmercury/models/event.dart';
import 'package:projectmercury/models/slot.dart';
import 'package:projectmercury/models/store_item.dart';
import 'package:projectmercury/models/transaction.dart';
import 'package:projectmercury/pages/eventPage/event_data.dart';
import 'package:projectmercury/pages/homePage/room.dart';
import 'package:projectmercury/pages/homePage/room_data.dart';
import 'package:projectmercury/resources/firestore_methods.dart';
import 'locator.dart';

class EventController with ChangeNotifier {
  final FirestoreMethods _firestore = locator.get<FirestoreMethods>();

  num _balance = 0;
  num get balance => _balance;

  int _session = 0;
  int get session => _session;

  Room? _sessionRoom;
  Room? get sessionRoom => _sessionRoom;

  List<int> _sessionProgress = [0, 1];
  List<int> get sessionProgress => _sessionProgress;

  List<PurchasedItem> _purchasedItems = [];
  List<PurchasedItem> get purchasedItems => _purchasedItems;
  List<Transaction> transactions = [];
  List<Event> deployedEvents = [];

  final List<bool> _showBadge = [false, false, false, false, false];
  List<bool> get showBadge => _showBadge;

  Future<void> update() async {
    await _firestore.waitingTransactionAction()
        ? _showBadge[1] = true
        : _showBadge[1] = false;
    await _firestore.waitingEventAction()
        ? _showBadge[3] = true
        : _showBadge[3] = false;
    sessionProgress[0] == sessionProgress[1]
        ? _showBadge[4] = true
        : _showBadge[4] = false;
    notifyListeners();
    if (_showBadge[3] == false) {
      deployEvent();
    }
  }

  List<Event> deployableEvents = events;

  void onBalanceChanged(num balance) {
    _balance = balance;
  }

  void onSessionChanged(int session) {
    _session = session;
    _sessionRoom = locator
        .get<Rooms>()
        .rooms
        .where((element) => element.unlockOrder == session)
        .first;
    calculateRoomProgress();
    update();
  }

  void onEventsChanged(List<Event> eventList) {
    deployedEvents = eventList;
    deployedEvents.sort((a, b) => b.timeSent!.compareTo(a.timeSent!));
  }

  void onTransactionsChanged(List<Transaction> transactionList) {
    transactions = transactionList;
    transactions.sort((a, b) => b.timeStamp!.compareTo(a.timeStamp!));
  }

  void onItemsChanged(List<PurchasedItem> itemList) {
    _purchasedItems = itemList;
    // update room slots
    furnishRoom();
    calculateRoomProgress();
  }

  Future<void> deployEvent() async {
    List<Event> deployable = [...deployableEvents];
    for (Event event in deployedEvents) {
      deployable.removeWhere((data) => data.eventId == event.eventId);
    }
    deployable.isNotEmpty
        ? Future.delayed(
            const Duration(
                seconds: /*Random().nextInt(eventMaxDelay - eventMinDelay) +
                    eventMinDelay*/
                    0),
            (() => _firestore.addEvent(deployable.first)),
          )
        : null;
  }

  void calculateRoomProgress() {
    _sessionProgress = [0, 1];
    if (sessionRoom != null) {
      int slotsTotal = sessionRoom!.slots.length;
      int slotsFilled =
          sessionRoom!.slots.where((element) => element.item != null).length;
      _sessionProgress = [slotsFilled, slotsTotal];
    }
  }

  void furnishRoom() {
    for (Room room in locator.get<Rooms>().rooms) {
      // reset room
      for (Slot slot in room.slots) {
        if (slot.item != null) {
          slot.set(null);
        }
      }
      // fill in slots
      List<PurchasedItem> roomItems = _purchasedItems
          .where((element) => element.room == room.name)
          .toList();
      if (roomItems.isNotEmpty) {
        for (PurchasedItem purchase in roomItems) {
          List<Slot> matchingSlot = room.slots
              .where((slot) => slot.items
                  .map((e) => e.name)
                  .toList()
                  .contains(purchase.item))
              .toList();
          matchingSlot.isNotEmpty
              ? matchingSlot.first.set(purchase.item)
              : null;
        }
      }
    }
  }
}
