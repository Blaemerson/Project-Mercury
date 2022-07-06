import 'dart:math';

import 'package:flutter/material.dart';
import 'package:projectmercury/models/store_item.dart';
import 'package:projectmercury/models/transaction.dart';
import 'package:projectmercury/resources/firestore_methods.dart';
import 'package:projectmercury/resources/locator.dart';
import 'package:projectmercury/utils/global_variables.dart';
import 'package:projectmercury/utils/utils.dart';

class StoreItemCard extends StatelessWidget {
  final StoreItem storeItem;
  final String room;
  const StoreItemCard({
    Key? key,
    required this.storeItem,
    required this.room,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirestoreMethods _firestore = locator.get<FirestoreMethods>();

    buyItem() async {
      num currentBalance =
          await _firestore.userFuture.then((value) => value.balance);
      if (currentBalance > storeItem.price) {
        _firestore.addItem(storeItem, room);
        double overcharge = Random().nextDouble();
        if (overcharge > overchargeFrequency) {
          _firestore.addTransaction(
            Transaction(
              description: 'Purchased ${storeItem.name}',
              amount: -storeItem.price,
            ),
          );
        } else {
          int overAmount = (Random().nextInt(maxOvercharge - minOvercharge) +
                  minOvercharge) *
              10;
          _firestore.addTransaction(
            Transaction(
              description: 'Purchased ${storeItem.name}',
              amount: -(storeItem.price + overAmount),
              overcharge: overAmount,
            ),
          );
        }
      } else {
        showSnackBar('Not enough funds.', context);
      }
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
                'assets/furniture/${storeItem.type + storeItem.variant}.png',
                height: 50,
              ),
              Text(formatCurrency.format(storeItem.price)),
              room != ''
                  ? ElevatedButton(
                      onPressed: () async {
                        if (await _firestore.waitingTransactionAction()) {
                          showConfirmation(
                              context: context,
                              static: true,
                              title: 'Purchase Failed',
                              text:
                                  'Make sure all transactions are resolved to make a new purchase.');
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
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
