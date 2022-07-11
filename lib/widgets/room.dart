import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:projectmercury/models/store_item.dart';
import 'package:projectmercury/resources/firestore_methods.dart';
import 'package:projectmercury/resources/locator.dart';
import 'package:projectmercury/widgets/furniture_card.dart';
import 'package:projectmercury/models/furniture_slot.dart';
import 'package:projectmercury/widgets/isometric.dart';

class Room extends StatelessWidget {
  final String name;
  final int unlockOrder;
  final List<FurnitureCard> items;
  final List<FurnitureSlot> openSlots;
  // TODO: make wall/flooring changable
  final String floorTexture;
  final String wallTexture;
  final double width;
  final double length;
  final double height;

  // For now, 300 is the max width/length for a room
  const Room({
    Key? key,
    required this.items,
    required this.width,
    required this.length,
    this.height = 90,
    required this.name,
    required this.unlockOrder,
    required this.floorTexture,
    required this.wallTexture,
    required this.openSlots,
  })  : assert(width <= 300 && length <= 300),
        super(key: key);

  // Items need extra space inside the Stack to get close to the walls, may need tweaking
  final _extraSpace = 80.0;

  @override
  Widget build(BuildContext context) {
    return IsometricView(
      child: SizedBox(
        /* color: Colors.blue, */
        width: width + _extraSpace,
        height: length + _extraSpace,
        child: StreamBuilder<List<PurchasedItem>>(
          stream: locator.get<FirestoreMethods>().itemsStream(room: name),
          builder: (context, roomItems) {
            if (roomItems.hasData) {
              // reset then place items in room
              for (FurnitureSlot slot in openSlots) {
                if (slot.item != null) {
                  slot.set(null);
                }
              }
              for (PurchasedItem purchase in roomItems.data!) {
                List<FurnitureSlot> matchingSlot = openSlots
                    .where((slot) => slot.items
                        .map((e) => e.name)
                        .toList()
                        .contains(purchase.item))
                    .toList();
                matchingSlot.isNotEmpty
                    ? matchingSlot.first.set(purchase.item)
                    : null;
              }
            }
            return Stack(
              alignment: AlignmentDirectional.bottomEnd,
              clipBehavior: Clip.none,
              children: [
                /* Left wall */
                PositionedDirectional(
                  top: 0,
                  start: _extraSpace,
                  child: Transform(
                    alignment: Alignment.topLeft,
                    transform: Matrix4.identity()..rotateY(-math.pi / 2),
                    child: SizedBox(
                      width: height,
                      height: length,
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.brown),
                            image: DecorationImage(
                              alignment: Alignment.topLeft,
                              opacity: .75,
                              image: AssetImage(wallTexture),
                              repeat: ImageRepeat.repeat,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                /* Right wall */
                PositionedDirectional(
                  bottom: _extraSpace,
                  end: 0,
                  child: Transform(
                    alignment: Alignment.bottomCenter,
                    transform: Matrix4.identity()..rotateX(-math.pi / 2),
                    child: Stack(
                      children: [
                        Container(
                          width: width,
                          height: height,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.brown),
                            image: DecorationImage(
                              opacity: .75,
                              image: AssetImage(wallTexture),
                              repeat: ImageRepeat.repeat,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /* Floor */
                PositionedDirectional(
                  top: 0,
                  end: 0,
                  child: Container(
                    width: width,
                    height: length,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.brown),
                      image: DecorationImage(
                        image: AssetImage(floorTexture),
                        repeat: ImageRepeat.repeat,
                      ),
                    ),
                  ),
                ),

                /* Items */
                for (FurnitureCard furniture in items) ...[
                  furniture,
                ],
                for (FurnitureSlot slot in openSlots) ...[
                  slot.item == null
                      ? slot
                      : slot.items.firstWhere((item) => item.name == slot.item),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
