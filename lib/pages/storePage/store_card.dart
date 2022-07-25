import 'package:flutter/material.dart';
import 'package:projectmercury/models/slot.dart';
import 'package:projectmercury/models/store_item.dart';
import 'package:projectmercury/models/transaction.dart';
import 'package:projectmercury/resources/event_controller.dart';
import 'package:projectmercury/resources/firestore_methods.dart';
import 'package:projectmercury/resources/locator.dart';
import 'package:projectmercury/utils/utils.dart';

class StoreItemCard extends StatelessWidget {
  final StoreItem storeItem;
  final String roomName;
  final Slot slot;
  const StoreItemCard({
    Key? key,
    required this.storeItem,
    required this.roomName,
    required this.slot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirestoreMethods _firestore = locator.get<FirestoreMethods>();

    buyItem() async {
      String itemId = await _firestore.addItem(storeItem, roomName);
      if (slot.scam.doubleCharge) {
        _firestore.addTransaction(
          Transaction(
            description:
                'Purchased ${storeItem.name} from ${storeItem.seller.real}',
            amount: -(storeItem.price),
            state: slot.scam.delay
                ? TransactionState.pending
                : TransactionState.actionNeeded,
            linkedItemId: itemId,
          ),
          double: true,
        );
      } else {
        _firestore.addTransaction(
          Transaction(
            description:
                'Purchased ${storeItem.name} from ${storeItem.seller.real}',
            amount: -(storeItem.price * (1 + slot.scam.overchargeRate)),
            overcharge: storeItem.price * slot.scam.overchargeRate,
            state: slot.scam.delay
                ? TransactionState.pending
                : TransactionState.actionNeeded,
            linkedItemId: itemId,
          ),
        );
      }
      locator.get<EventController>().deployEvent();
      Navigator.pop(context);
    }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: FittedBox(
        fit: BoxFit.fitHeight,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          width: 125,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.brown),
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                storeItem.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Sold by: ${storeItem.seller.real}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
              Image.asset(
                'assets/furniture/${storeItem.item}.png',
                errorBuilder: (context, _, stacktrace) {
                  return Image.asset(
                    'assets/furniture/${storeItem.item}_NE.png',
                    height: 50,
                  );
                },
                height: 50,
              ),
              Text(formatCurrency.format(storeItem.price)),
              ElevatedButton(
                onPressed: () async {
                  if (locator
                      .get<EventController>()
                      .waitingTransactionAction()) {
                    showConfirmation(
                        context: context,
                        static: true,
                        title: 'Purchase Failed',
                        text:
                            'Complete all transactions to make a new purchase.');
                  } else if (locator
                      .get<EventController>()
                      .waitingEventAction()) {
                    showConfirmation(
                        context: context,
                        static: true,
                        title: 'Purchase Failed',
                        text: 'Complete all events to make a new purchase.');
                  } else {
                    bool result = await showConfirmation(
                          context: context,
                          title: 'Confirmation',
                          text: 'Purchase this item?',
                        ) ??
                        false;
                    if (result == true) {
                      buyItem();
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: Text(
                  'Buy Item',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
