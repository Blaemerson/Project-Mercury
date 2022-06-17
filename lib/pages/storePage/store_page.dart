import 'package:flutter/material.dart';
import 'package:projectmercury/models/store_item.dart';
import 'package:projectmercury/pages/storePage/store_card.dart';
import 'package:projectmercury/pages/storePage/store_data.dart';
import 'package:projectmercury/widgets/room.dart';

class StorePage extends StatelessWidget {
  final Room room;
  const StorePage({
    required this.room,
    Key? key,
  }) : super(key: key);

// better store layout .. separate items by type?
  @override
  Widget build(BuildContext context) {
    List<String> openSlots = [];
    room.items.where((element) => element.variant == null).forEach((element) {
      openSlots.add(element.type);
    });
    openSlots = openSlots.toSet().toList();

    List<StoreItem> getItemsByType(String type) {
      return storeItems.where((element) => element.type == type).toList();
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
              if (openSlots.isNotEmpty) ...[
                for (String type in openSlots)
                  if (getItemsByType(type).isNotEmpty) ...[
                    const Divider(),
                    Center(
                      child: Text(
                        '${type.toUpperCase()}S',
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
                const Center(
                  child: Text('No room left for furniture.'),
                ),
              ],
              // SizedBox(
              //   height: 200,
              //   child: ListView.builder(
              //     itemBuilder: (context, index) {
              //       return StoreItemCard(
              //         storeItem: storeItems[index],
              //       );
              //     },
              //     itemCount: storeItems.length,
              //     scrollDirection: Axis.horizontal,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
