import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:projectmercury/models/event.dart';
import 'package:projectmercury/models/furniture.dart';
import 'package:projectmercury/models/scam.dart';
import 'package:projectmercury/models/slot.dart';
import 'package:projectmercury/models/store_item.dart';
import 'package:projectmercury/models/transaction.dart';
import 'package:projectmercury/pages/eventPage/event_data.dart';
import 'package:projectmercury/pages/homePage/room.dart';
import 'package:projectmercury/pages/homePage/room_data.dart';
import 'package:projectmercury/pages/storePage/store_data.dart';
import 'package:projectmercury/resources/firestore_methods.dart';
import 'locator.dart';

class EventController with ChangeNotifier {
  final FirestoreMethods _firestore = locator.get<FirestoreMethods>();

  int _currentPage = 0;
  int get currentPage => _currentPage;
  set currentPage(int page) => _currentPage = page;

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
  Transaction? getTransaction(String? id) {
    Iterable<Transaction> match =
        transactions.where((element) => element.id == id);
    return match.isNotEmpty ? match.first : null;
  }

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
        rooms.firstWhere((element) => element.unlockOrder == session);
    rooms.sort(((a, b) => a.unlockOrder.compareTo(b.unlockOrder)));
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
    updateBadge(0);
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
      int slotsFilled = sessionRoom!.filledSlots.length;
      _roomProgress = [slotsFilled, slotsTotal];
      calculateEventProgress();
    }
  }

//TODO: better way to calculate event progress
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
    _eventProgress = [eventsDone, eventsTotal];
    calculateSessionProgress();
  }

  void calculateSessionProgress() {
    int denom = _roomProgress[1] + _eventProgress[1];
    _sessionProgress =
        denom != 0 ? ((_roomProgress[0] + _eventProgress[0]) / denom) : 1;
    // _sessionProgress = 1;
    updateBadge(4);
  }

  void furnishRoom() {
    for (Room room in rooms) {
      // reset room
      room.fillSlots(null, null);
      // fill in slots
      List<PurchasedItem> roomItems =
          purchasedItems.where((element) => element.room == room.name).toList();
      if (roomItems.isNotEmpty) {
        for (PurchasedItem purchase in roomItems) {
          List<Slot> matchingSlot = room.slots
              .where((slot) => slot.get(purchase.item).toList().isNotEmpty)
              .toList();
          if (purchase.delivered) {
            // Fill all slots that take a given item
            if (matchingSlot.isNotEmpty) {
              matchingSlot.forEach(((element) => element.set(purchase.item)));
            }
          } else {
            if (matchingSlot.isNotEmpty) {
              matchingSlot.forEach(((element) => element.owned = true));
            }
          }
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

  Future<void> markRead(String eventId) async {
    _firestore.markEventAsOpened(eventId);
  }

//TODO: implement utility bill deployment
  buyItem(StoreItem item, String room, Slot slot) async {
    String itemId = await _firestore.addItem(item, room);
    _firestore.addEvent(
      Event(
        eventId: 0,
        sender: item.seller.real,
        title: 'Recipt for ${item.name}',
        type: EventType.email,
        dialog: [
          item.item,
          'Thank you for shopping at ${item.seller.real}.',
          'This is a recipt to confirm that you have purchased ${item.name} for \$${item.price} on ${DateFormat.yMd().add_jm().format(DateTime.now())}.'
        ],
        state: EventState.static,
      ),
    );
    deployEvent();
    slot.owned = true;
    if (slot.scam.doubleCharge) {
      _firestore.addTransaction(
        Transaction(
          description: 'Purchased ${item.name} from ${item.seller.real}',
          amount: -(item.price),
          state: slot.scam.delay
              ? TransactionState.pending
              : TransactionState.actionNeeded,
          linkedItemId: itemId,
        ),
        double: true,
      );
      return;
    }
    if (slot.scam.scamStore) {
      _firestore.addTransaction(
        Transaction(
            description: 'Purchased ${item.name} from ${item.seller.fake}',
            amount: -item.price,
            state: slot.scam.delay
                ? TransactionState.pending
                : TransactionState.actionNeeded,
            linkedItemId: itemId,
            isScam: true,
            deployOnDispute: [
              Transaction(
                description: 'Fake Item Refund:',
                amount: item.price,
                state: TransactionState.pending,
              ),
            ],
            deployOnResolved: [
              Transaction(
                description: 'Purchased ${item.name} from ${item.seller.real}',
                amount: -item.price,
                state: TransactionState.pending,
              ),
            ]),
      );
      return;
    }
    if (slot.scam.scamStoreDuplicate) {
      _firestore.addTransaction(
        Transaction(
            description: 'Purchased ${item.name} from ${item.seller.real}',
            amount: -item.price,
            state: slot.scam.delay
                ? TransactionState.pending
                : TransactionState.actionNeeded,
            linkedItemId: itemId,
            deployOnResolved: [
              Transaction(
                  description:
                      'Purchased ${item.name} from ${item.seller.fake}',
                  amount: -item.price,
                  isScam: true,
                  deployOnDispute: [
                    Transaction(
                      description: 'Fake Item Refund:',
                      amount: item.price,
                      state: TransactionState.pending,
                    ),
                  ]),
            ]),
      );
      return;
    }
    if (slot.scam.wrongSlotItem) {
      List<Furniture> otherOptions = slot.acceptables
          .where((element) => element.name != item.name)
          .toList();
      String randomName =
          otherOptions[Random().nextInt(otherOptions.length)].name;
      StoreItem wrongItem =
          storeItems.firstWhere((element) => element.item == randomName);
      _firestore.addTransaction(
        Transaction(
            description:
                'Purchased ${wrongItem.name} from ${wrongItem.seller.real}',
            amount: -wrongItem.price,
            state: slot.scam.delay
                ? TransactionState.pending
                : TransactionState.actionNeeded,
            linkedItemId: itemId,
            isScam: true,
            deployOnDispute: [
              Transaction(
                description: 'Wrong Item Refund:',
                amount: wrongItem.price,
                state: TransactionState.pending,
              ),
            ],
            deployOnResolved: [
              Transaction(
                description: 'Purchased ${item.name} from ${item.seller.real}',
                amount: -item.price,
                state: TransactionState.pending,
              ),
            ]),
      );
      return;
    }
    if (slot.scam.wrongRandomItem) {
      List<StoreItem> randomItems =
          storeItems.where((element) => element.name != item.name).toList();
      StoreItem wrongItem = randomItems[Random().nextInt(randomItems.length)];
      _firestore.addTransaction(
        Transaction(
          description:
              'Purchased ${wrongItem.name} from ${wrongItem.seller.real}',
          amount: -wrongItem.price,
          state: slot.scam.delay
              ? TransactionState.pending
              : TransactionState.actionNeeded,
          linkedItemId: itemId,
          isScam: true,
          deployOnDispute: [
            Transaction(
              description: 'Wrong Item Refund:',
              amount: wrongItem.price,
              state: TransactionState.pending,
            ),
          ],
          deployOnResolved: [
            Transaction(
              description: 'Purchased ${item.name} from ${item.seller.real}',
              amount: -item.price,
              state: TransactionState.pending,
            ),
          ],
        ),
      );
      return;
    }
    if (slot.scam.overchargeRate != 0) {
      _firestore.addTransaction(
        Transaction(
          description: 'Purchased ${item.name} from ${item.seller.real}',
          amount: -(item.price * (1 + slot.scam.overchargeRate)),
          isScam: true,
          state: slot.scam.delay
              ? TransactionState.pending
              : TransactionState.actionNeeded,
          linkedItemId: itemId,
          deployOnDispute: [
            Transaction(
              description: 'Overcharge Refund:',
              amount: item.price * slot.scam.overchargeRate,
              state: TransactionState.pending,
            ),
          ],
        ),
      );
      return;
    }
    _firestore.addTransaction(
      Transaction(
        description: 'Purchased ${item.name} from ${item.seller.real}',
        amount: -item.price,
        state: slot.scam.delay
            ? TransactionState.pending
            : TransactionState.actionNeeded,
        linkedItemId: itemId,
      ),
    );
  }
}
