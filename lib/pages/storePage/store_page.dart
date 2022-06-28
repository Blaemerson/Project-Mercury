import 'package:flutter/material.dart';
import 'package:projectmercury/models/store_item.dart';
import 'package:projectmercury/pages/storePage/store_card.dart';
import 'package:projectmercury/pages/storePage/store_data.dart';
import 'package:projectmercury/widgets/room.dart';
import 'package:provider/provider.dart';

class StorePage extends StatelessWidget {
  final Room room;
  final String furnitureType;
  const StorePage({
    required this.room,
    this.furnitureType = '',
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> openSlots = [];
    room.items
        .where((furniture) =>
            furniture.variant == null &&
            (furnitureType == '' ? true : furniture.type == furnitureType))
        .forEach((furniture) {
      openSlots.add(furniture.type);
    });
    openSlots = openSlots.toSet().toList();

    List<StoreItem> getItemsByType(String type) {
      return storeItems.where((item) => item.type == type).toList();
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
                    (furnitureType != '' ? furnitureType.toUpperCase() : 'Furniture') + ' Store',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              if (openSlots.isNotEmpty) ...[
                for (String type in openSlots)
                  if (getItemsByType(type).isNotEmpty) ...[
                    const Divider(),
                    Center(
                      child: Text(
                        '${type.toUpperCase()} Selection',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return StoreItemCard(
                            storeItem: getItemsByType(type)[index],
                            room: room.name,
                          );
                        },
                        itemCount: getItemsByType(type).length,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ],
              ] else ...[
                //TODO: add sell item option
                Center(
                  child: Text(
                    'Congratulations! Your ${room.name} is fully furnished.',
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
              Consumer<List<PurchasedItem>>(
                builder: (_, userItems, __) {
                  List<PurchasedItem> roomItems = userItems
                      .where((element) => element.room == room.name)
                      .toList();
                  if (roomItems.isNotEmpty) {
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
