import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projectmercury/models/slot.dart';
/* import 'package:projectmercury/models/slot.dart'; */
import 'package:projectmercury/models/store_item.dart';
import 'package:projectmercury/models/transaction.dart';
import 'package:projectmercury/resources/event_controller.dart';
import 'package:projectmercury/resources/firestore_methods.dart';
import 'package:projectmercury/resources/locator.dart';
import 'package:projectmercury/utils/utils.dart';
import 'dart:io';

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
      if (slot.doubleCharge) {
        _firestore.addTransaction(
          Transaction(
            description: 'Purchased ${storeItem.name}',
            amount: -(storeItem.price),
            state: slot.delay
                ? TransactionState.pending
                : TransactionState.actionNeeded,
            linkedItemId: itemId,
          ),
          double: true,
        );
      } else {
        _firestore.addTransaction(
          Transaction(
            description: 'Purchased ${storeItem.name}',
            amount: -(storeItem.price * (1 + slot.overchargeRate)),
            overcharge: storeItem.price * slot.overchargeRate,
            state: slot.delay
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
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.brown),
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(storeItem.name),
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
                            'Make sure all transactions are resolved to make a new purchase.');
                  } else if (locator
                      .get<EventController>()
                      .waitingEventAction()) {
                    showConfirmation(
                        context: context,
                        static: true,
                        title: 'Purchase Failed',
                        text:
                            'Make sure all events are completed to make a new purchase.');
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
