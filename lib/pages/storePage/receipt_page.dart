import 'package:flutter/material.dart';
import 'package:projectmercury/models/store_item.dart';
import 'package:projectmercury/pages/homePage/room.dart';
import 'package:projectmercury/pages/homePage/room_data.dart';
import 'package:projectmercury/pages/storePage/receipt_card.dart';
import 'package:projectmercury/resources/event_controller.dart';
import 'package:projectmercury/resources/locator.dart';
import 'package:projectmercury/utils/utils.dart';

class ReceiptPage extends StatelessWidget {
  const ReceiptPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<PurchasedItem> items = locator.get<EventController>().purchasedItems;
    List<Room> rooms = locator.get<Rooms>().rooms;
    rooms.sort(
      (a, b) => b.unlockOrder.compareTo(a.unlockOrder),
    );

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
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Purchase History',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: ListView(
                    controller: scrollController,
                    children: [
                      for (Room room in rooms) ...[
                        if (items
                            .where((element) => element.room == room.name)
                            .isNotEmpty) ...[
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: Colors.grey[700],
                                  indent: 10,
                                  endIndent: 10,
                                  thickness: 3,
                                ),
                              ),
                              Text(
                                capitalize(room.name),
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: Colors.grey[700],
                                  indent: 10,
                                  endIndent: 10,
                                  thickness: 3,
                                ),
                              ),
                            ],
                          ),
                          for (PurchasedItem item in items.where(
                              (element) => element.room == room.name)) ...[
                            ReceiptCard(purchasedItem: item),
                          ]
                        ],
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
