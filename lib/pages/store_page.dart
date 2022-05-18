import 'package:flutter/material.dart';

import '../utils/global_variables.dart';
import '../widgets/store_item_card.dart';

class StorePage extends StatelessWidget {
  const StorePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      insetPadding: const EdgeInsets.symmetric(vertical: 200, horizontal: 0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            alignment: Alignment.center,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
            ),
            child: const Text(
              'Furniture Store',
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Flexible(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return StoreItemCard(
                  storeItem: storeItems[index],
                );
              },
              itemCount: storeItems.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Flexible(
            flex: 3,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return StoreItemCard(
                  storeItem: storeItems[index],
                );
              },
              itemCount: storeItems.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      ),
    );
  }
}
