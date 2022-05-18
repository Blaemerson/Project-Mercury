import 'package:flutter/material.dart';
import 'package:projectmercury/models/store_item.dart';
import 'package:projectmercury/utils/global_variables.dart';

class StoreItemCard extends StatelessWidget {
  final StoreItem storeItem;
  const StoreItemCard({Key? key, required this.storeItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FittedBox(
            child: Container(
              width: 100,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.pink[100],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(storeItem.name),
                  storeItem.icon,
                  Text(formatCurrency.format(storeItem.price)),
                  const SizedBox(height: 18),
                ],
              ),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {},
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
    );
  }
}
