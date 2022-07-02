import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:projectmercury/models/store_item.dart';
import 'package:projectmercury/pages/storePage/store_page.dart';
import 'package:projectmercury/resources/firestore_methods.dart';
import 'package:projectmercury/resources/locator.dart';
import 'package:projectmercury/widgets/furniture_card.dart';
import 'package:projectmercury/models/furniture_slot.dart';
import 'package:projectmercury/widgets/isometric.dart';

class Room extends StatelessWidget {
  final String name;
  final int unlockOrder;
  final List<FurnitureSlot> items;
  // TODO: Possibly make wall/flooring changable
  final String floorTexture;
  final String wallTexture;
  final double extendLeft;
  final double extendRight;
  final double wallHeight;

  // For now, 300 is the max width/length for a room
  const Room({
    Key? key,
    required this.items,
    required this.extendLeft,
    required this.extendRight,
    this.wallHeight = 90,
    required this.name,
    required this.unlockOrder,
    required this.floorTexture,
    required this.wallTexture,
  })  : assert(extendLeft <= 300 && extendRight <= 300),
        super(key: key);

  // Items need extra space inside the Stack to get close to the walls, may need tweaking
  final _extraSpace = 60.0;

  @override
  Widget build(BuildContext context) {
    return IsometricView(
      child: SizedBox(
        /* color: Colors.blue, */
        width: extendLeft + _extraSpace,
        height: extendRight + _extraSpace,
        child: StreamBuilder<List<PurchasedItem>>(
            stream: locator.get<FirestoreMethods>().itemsStream(room: name),
            builder: (context, roomItems) {
              if (roomItems.hasData) {
                // reset then place items in room
                for (FurnitureSlot slot in items) {
                  if (slot.variant != '') {
                    slot.set(null);
                  }
                }
                for (PurchasedItem item in roomItems.data!) {
                  List<FurnitureSlot> matchingSlot = items
                      .where((slot) =>
                          slot.type == item.type && slot.variant == null)
                      .toList();
                  matchingSlot.isNotEmpty
                      ? matchingSlot.first.set(item.variant)
                      : null;
                }
              }

              return Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  /* Left wall */
                  PositionedDirectional(
                    top: 0,
                    start: _extraSpace,
                    child: Transform(
                      alignment: Alignment.topLeft,
                      transform: Matrix4.identity()..rotateY(-math.pi / 2),
                      child: SizedBox(
                        width: wallHeight,
                        height: extendRight,
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
                            width: extendLeft,
                            height: wallHeight,
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
                      width: extendLeft,
                      height: extendRight,
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
                  for (FurnitureSlot slot in items) ...[
                    Positioned(
                      left: (extendLeft * slot.distanceFromLeft),
                      bottom: (extendRight * slot.distanceFromRight),
                      child: slot.variant == null
                          ? GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16),
                                    ),
                                  ),
                                  context: context,
                                  builder: (context) {
                                    return StorePage(
                                        room: this, furnitureType: slot.type);
                                  },
                                );
                              },
                              child: FurnitureCard(furniture: slot),
                            )
                          : FurnitureCard(furniture: slot),
                    ),
                  ],
                ],
              );
            }),
      ),
    );
  }
}
