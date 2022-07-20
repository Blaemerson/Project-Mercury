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

  Room? _currentRoom;
  Room? get currentRoom => _currentRoom;
  setRoom(Room? room) {
    _currentRoom = room;
  }

  final List<Room> _rooms = [
    bedroom,
    livingroom,
    bathroom,
    kitchen,
    diningroom,
    washroom,
  ];
  List<Room> get rooms => _rooms;

  num _balance = 0;
  num get balance => _balance;

  int _session = 0;
  int get session => _session;

  Room? _sessionRoom;
  Room? get sessionRoom => _sessionRoom;

  double _sessionProgress = 0;
  double get sessionProgress => _sessionProgress;

  List<int> _roomProgress = [0, 0];
  List<int> get roomProgress => _roomProgress;

  List<int> _eventProgress = [0, 0];
  List<int> get eventProgress => _eventProgress;

  List<PurchasedItem>? _purchasedItems;
  List<PurchasedItem> get purchasedItems => _purchasedItems ?? [];

  List<Transaction>? _transactions;
  List<Transaction> get transactions => _transactions ?? [];

  List<Event>? _deployedEvents;
  List<Event> get deployedEvents => _deployedEvents ?? [];

  final List<bool> _showBadge = [false, false, false, false, false];
  List<bool> get showBadge => _showBadge;

  bool waitingTransactionAction() {
    return transactions
        .where((element) => element.state == TransactionState.actionNeeded)
        .isNotEmpty;
  }

  bool waitingEventAction() {
    return deployedEvents
        .where((element) => element.state == EventState.actionNeeded)
        .isNotEmpty;
  }

  List<Transaction> get pendingTransactions {
    return transactions
        .where((element) => element.state == TransactionState.pending)
        .toList();
  }

  void onBalanceChanged(num balance) {
    _balance = balance;
    notifyListeners();
  }

  void onSessionChanged(int session) {
    _session = session;
    _sessionRoom =
        rooms.where((element) => element.unlockOrder == session).first;
    calculateRoomProgress();
    updateBadge(0);
    notifyListeners();
  }

  void onEventsChanged(List<Event> eventList) {
    _deployedEvents = eventList;
    deployedEvents.sort((a, b) => b.timeSent!.compareTo(a.timeSent!));
    calculateEventProgress();
    updateBadge(3);
    updateBadge(0);
    notifyListeners();
  }

  void onTransactionsChanged(List<Transaction> transactionList) {
    _transactions = transactionList;
    transactions.sort((a, b) => b.timeStamp!.compareTo(a.timeStamp!));
    updateBadge(1);
    updateBadge(0);
    notifyListeners();
  }

  void onItemsChanged(List<PurchasedItem> itemList) {
    _purchasedItems = itemList;
    furnishRoom();
    calculateRoomProgress();
    notifyListeners();
  }

  void updateBadge(int page) {
    switch (page) {
      case 0:
        (roomProgress[0] != roomProgress[1] &&
                showBadge[1] == false &&
                showBadge[3] == false)
            ? _showBadge[0] = true
            : _showBadge[0] = false;
        break;
      case 1:
        waitingTransactionAction()
            ? _showBadge[1] = true
            : _showBadge[1] = false;
        break;
      case 2:
        break;
      case 3:
        waitingEventAction() ? _showBadge[3] = true : _showBadge[3] = false;
        break;
      case 4:
        sessionProgress == 1 ? _showBadge[4] = true : _showBadge[4] = false;
        break;
      default:
    }
  }

  void calculateRoomProgress() {
    _roomProgress = [0, 0];
    if (sessionRoom != null) {
      int slotsTotal = sessionRoom!.slots.length;
      int slotsFilled =
          sessionRoom!.slots.where((element) => element.item != null).length;
      _roomProgress = [slotsFilled, slotsTotal];
      calculateEventProgress();
    }
  }

  void calculateEventProgress() {
    _eventProgress = [0, 0];
    int eventsTotal = events
        .where((element) =>
            element.eventId >= _session * 100 &&
            element.eventId < (_session + 1) * 100)
        .length;
    int eventsDone = deployedEvents
        .where((element) =>
            element.eventId >= _session * 100 &&
            element.eventId < (_session + 1) * 100)
        .where((element) => element.state != EventState.actionNeeded)
        .length;
    if (eventsTotal > roomProgress[1]) {
      eventsTotal = roomProgress[1];
    }
    _eventProgress = [eventsDone, eventsTotal];
    calculateSessionProgress();
  }

// TODO: calculate transaction progress
  void calculateSessionProgress() {
    int denom = _roomProgress[1] + _eventProgress[1];
    _sessionProgress =
        (_roomProgress[0] + _eventProgress[0]) / (denom != 0 ? denom : 1);
    // _sessionProgress = 1;
    updateBadge(4);
  }

  void furnishRoom() {
    for (Room room in rooms) {
      // reset room
      for (Slot slot in room.slots) {
        if (slot.item != null) {
          slot.set(null);
        }
      }
      // fill in slots
      List<PurchasedItem> roomItems =
          purchasedItems.where((element) => element.room == room.name).toList();
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

  Future<void> deployEvent() async {
    List<Event> deployable = [...events];
    for (Event event in deployedEvents) {
      deployable.removeWhere((data) => data.eventId == event.eventId);
    }
    deployable.isNotEmpty
        ? await Future.delayed(
            const Duration(
                seconds: /*Random().nextInt(eventMaxDelay - eventMinDelay) +
                    eventMinDelay*/
                    0),
            (() => _firestore.addEvent(deployable.first)),
          )
        : null;
  }
}
