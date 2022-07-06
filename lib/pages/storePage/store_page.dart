import 'package:flutter/material.dart';
import 'package:projectmercury/models/store_item.dart';
import 'package:projectmercury/pages/storePage/store_card.dart';
import 'package:projectmercury/pages/storePage/store_data.dart';
import 'package:projectmercury/resources/firestore_methods.dart';
import 'package:projectmercury/resources/locator.dart';
import 'package:projectmercury/widgets/room.dart';

class StorePage extends StatelessWidget {
  final Room room;
  final List<String> slotItems;
  const StorePage({
    required this.room,
    this.slotItems = const <String>[],
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> sellableItems = [];
    room.items
        .where((furniture) => furniture.item == null)
        .forEach((furniture) {
      sellableItems.addAll(slotItems.isNotEmpty ? slotItems : furniture.possibleItems);
    });
    sellableItems = sellableItems.toSet().toList();

    List<StoreItem> getItems(List<String> items) {
      return storeItems.where((item) => items.contains(item.item)).toList();
    }

    Widget makeDismissible({required Widget child}) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(
          onTap: () {},
          child: child,
        ),
      );
    }

    return makeDismissible(
      child: DraggableScrollableSheet(
        maxChildSize: 1,
        initialChildSize: 0.5,
        minChildSize: 0.3,
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
              if (sellableItems.isNotEmpty) ...[
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
                        storeItem: getItems(sellableItems)[index],
                        room: room.name,
                      );
                    },
                    itemCount: getItems(sellableItems).length,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ] else ...[
                Center(
                  child: Text(
                    'Congratulations! Your ${room.name} is fully furnished.',
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
              StreamBuilder<List<PurchasedItem>>(
                stream: locator
                    .get<FirestoreMethods>()
                    .itemsStream(room: room.name),
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
                                room: '',
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
    );
  }
}
