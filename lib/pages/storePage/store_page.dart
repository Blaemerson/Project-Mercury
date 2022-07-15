import 'package:flutter/material.dart';
import 'package:projectmercury/models/furniture.dart';
import 'package:projectmercury/models/slot.dart';
import 'package:projectmercury/models/store_item.dart';
import 'package:projectmercury/pages/storePage/store_card.dart';
import 'package:projectmercury/pages/storePage/store_data.dart';
import 'package:projectmercury/resources/firestore_methods.dart';
import 'package:projectmercury/resources/locator.dart';

class StorePage extends StatelessWidget {
  final String room;
  final Slot? slot;
  const StorePage({
    required this.room,
    this.slot,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<StoreItem> getItems(List<Furniture> items) {
      return storeItems
          .where(
              (item) => items.map((e) => e.name).toList().contains(item.item))
          .toList();
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).pop(),
      child: GestureDetector(
        onTap: () {},
        child: DraggableScrollableSheet(
          maxChildSize: 0.6,
          initialChildSize: 0.5,
          minChildSize: 0.4,
          builder: (context, scrollController) => Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: ListView(
              controller: scrollController,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Furniture Store',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                if (slot!.items.isNotEmpty) ...[
                  /* for (String item in sellableItems) const Divider(), */
                  const Center(
                    child: Text(
                      'Item Selection',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return StoreItemCard(
                          storeItem: getItems(slot!.items)[index],
                          room: slot!.room,
                          overchargeRate: slot!.overchargeRate,
                          doubleCharge: slot!.doubleCharge,
                        );
                      },
                      itemCount: getItems(slot!.items).length,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ] else ...[
                  Center(
                    child: Text(
                      'Congratulations! Your ${slot!.room} is fully furnished.',
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
                StreamBuilder<List<PurchasedItem>>(
                  stream: locator
                      .get<FirestoreMethods>()
                      .itemsStream(room: slot!.room),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<PurchasedItem> roomItems = snapshot.data!;
                      return Column(
                        children: [
                          const Divider(),
                          const Center(
                            child: Text(
                              'Purchased Furnitures',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          SizedBox(
                            height: 120,
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return StoreItemCard(
                                  storeItem: roomItems[index],
                                );
                              },
                              itemCount: roomItems.length,
                              scrollDirection: Axis.horizontal,
                            ),
                          ),
                        ],
                      );
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
