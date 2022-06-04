import 'package:flutter/material.dart';
import 'package:projectmercury/models/store_item.dart';
import 'package:provider/provider.dart';

import '../widgets/store_item_card.dart';

class StorePage extends StatelessWidget {
  const StorePage({
    Key? key,
  }) : super(key: key);

// better store layout .. separate items by type?
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Furniture Store',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 300,
          child: Consumer<List<StoreItem>>(
            builder: (_, storeItems, __) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return StoreItemCard(
                    storeItem: storeItems[index],
                  );
                },
                itemCount: storeItems.length,
                scrollDirection: Axis.horizontal,
              );
            },
          ),
        ),
      ],
    );
  }
}
