import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:projectmercury/models/store_item.dart';
import 'package:projectmercury/widgets/furniture_card.dart';
import 'package:projectmercury/models/furniture_slot.dart';
import 'package:projectmercury/widgets/isometric.dart';
import 'package:provider/provider.dart';

class Room extends StatefulWidget {
  final String name;
  final int unlockOrder;
  final List<FurnitureSlot> items;
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

  update(String type, String variant) {
    items.where((item) => item.type == type).first.set(variant);
  }

  @override
  State<Room> createState() => _RoomState();
}

class _RoomState extends State<Room> {
  // Items need extra space inside the Stack to get close to the walls, may need tweaking
  final _extraSpace = 60.0;

  @override
  Widget build(BuildContext context) {
    return Consumer<List<PurchasedItem>>(
      builder: (_, userItems, __) {
        // reset room
        for (FurnitureSlot slot in widget.items) {
          if (slot.variant != '') {
            slot.set(null);
          }
        }

        // place purchased items in room
        List<PurchasedItem> roomItems =
            userItems.where((item) => item.room == widget.name).toList();
        for (PurchasedItem item in roomItems) {
          List<FurnitureSlot> matchingSlot = widget.items
              .where((slot) => slot.type == item.type && slot.variant == null)
              .toList();
          matchingSlot.isNotEmpty ? matchingSlot.first.set(item.variant) : null;
        }

        return IsometricView(
          child: Container(
            /* color: Colors.blue, */
            width: widget.extendLeft + _extraSpace,
            height: widget.extendRight + _extraSpace,
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                /* Left wall */
                PositionedDirectional(
                  top: 0,
                  start: _extraSpace,
                  child: Transform(
                    alignment: Alignment.topLeft,
                    transform: Matrix4.identity()
                      ..rotateY(-math.pi / 2),
                    child: SizedBox(
                      width: widget.wallHeight,
                      height: widget.extendRight,
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.brown),
                            image: DecorationImage(
                              alignment: Alignment.topLeft,
                              opacity: .75,
                              image: AssetImage(widget.wallTexture),
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
                          width: widget.extendLeft,
                          height: widget.wallHeight,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.brown),
                            image: DecorationImage(
                              opacity: .75,
                              image: AssetImage(widget.wallTexture),
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
                    width: widget.extendLeft,
                    height: widget.extendRight,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.brown),
                      image: DecorationImage(
                        image: AssetImage(widget.floorTexture),
                        repeat: ImageRepeat.repeat,
                      ),
                    ),
                  ),
                ),

                /* Items */
                for (FurnitureSlot slot in widget.items) ...[
                  Positioned(
                    left: (widget.extendLeft * slot.distanceFromLeft),
                    bottom: (widget.extendRight * slot.distanceFromRight),
                    child: Actor(
                      child: FurnitureCard(furniture: slot),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
