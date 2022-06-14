import 'package:flutter/material.dart';
import 'package:projectmercury/models/store_item.dart';
import 'package:projectmercury/pages/storePage/store_item_card.dart';
import 'package:provider/provider.dart';

class StorePage extends StatelessWidget {
  const StorePage({
    Key? key,
  }) : super(key: key);

// better store layout .. separate items by type?
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
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
            padding: const EdgeInsets.all(2.0),
            child: Text(
              'Furniture Store',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 200,
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
