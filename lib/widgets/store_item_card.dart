import 'package:flutter/material.dart';
import 'package:projectmercury/models/store_item.dart';
import 'package:projectmercury/models/transaction.dart';
import 'package:projectmercury/resources/auth_methods.dart';
import 'package:projectmercury/resources/firestore_methods.dart';
import 'package:projectmercury/resources/locator.dart';
import 'package:projectmercury/utils/global_variables.dart';
import 'package:uuid/uuid.dart';

class StoreItemCard extends StatelessWidget {
  final StoreItem storeItem;
  const StoreItemCard({Key? key, required this.storeItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirestoreMethods _firestore = locator.get<FirestoreMethods>();
    AuthMethods _auth = locator.get<AuthMethods>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FittedBox(
        fit: BoxFit.fitHeight,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(storeItem.name),
              Icon(IconData(storeItem.icon, fontFamily: 'MaterialIcons')),
              Text(formatCurrency.format(storeItem.price)),
              ElevatedButton(
                onPressed: () {
                  String id = const Uuid().v1();
                  _firestore.buyItem(_auth.currentUser.uid, storeItem);
                  _firestore.transaction.add(
                    id,
                    Transaction(
                      description: 'Purchased ${storeItem.name}',
                      amount: -storeItem.price,
                      timeStamp: DateTime.now(),
                      id: id,
                    ),
                  );
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
