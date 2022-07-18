/// This widget builds a room in true isometric perspective/
/// On building, occupied and unoccupied furniture slots are additionally loaded in.
/// Heavily relies on Flutter's stack widget to overlay/position room components/items.

import 'package:flutter/material.dart';
import 'package:projectmercury/models/furniture.dart';
import 'package:projectmercury/models/slot.dart';
import 'dart:math' as math;

import 'package:projectmercury/models/store_item.dart';
import 'package:projectmercury/pages/homePage/furniture_card.dart';
import 'package:projectmercury/pages/homePage/furniture_slot.dart';
import 'package:projectmercury/pages/homePage/isometric.dart';
import 'package:projectmercury/resources/firestore_methods.dart';
import 'package:projectmercury/resources/locator.dart';

class Room extends StatefulWidget {
  final String name; // Name of this room ("bedroom", "livingroom", ...)
  final int unlockOrder; // Session number on which users unlock this room.
  final List<Furniture> items; // List of furniture to be loaded into room initially.
  final List<Slot> slots; // Slots that appear empty and must have their item purchased to appear.
  final String floorTexture; // Path to asset used for wall texture.
  final String wallTexture; // Path to asset used for floor texture.
  final double width; // Width of room; visually, distance from back-left wall to front-right wall
  final double length; // Length of room; visually, distance from back-right wall to front-left wall
  final double height; // Height of walls

  // 300 is the max width/length for a room, to avoid wall displacement and other deformaties
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
    required this.slots,
  })  : assert(width <= 300 && length <= 300),
        super(key: key);

  @override
  State<Room> createState() => _RoomState();
}

class _RoomState extends State<Room> {
  // Items need extra space inside the Stack to get close to the walls, may need tweaking
  final _extraSpace = 80.0;

  @override
  Widget build(BuildContext context) {
    return IsometricView(
      child: SizedBox(
        width: widget.width + _extraSpace,
        height: widget.length + _extraSpace,
        child: StreamBuilder<List<PurchasedItem>>(
          stream:
              locator.get<FirestoreMethods>().itemsStream(room: widget.name),
          builder: (context, roomItems) {
            return Stack(
              alignment: AlignmentDirectional.bottomEnd,
              clipBehavior: Clip.none,
              children: [
                /* Floor */
                PositionedDirectional(
                  top: 0,
                  end: 0,
                  child: Container(
                    width: widget.width,
                    height: widget.length,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.brown),
                      image: DecorationImage(
                        image: AssetImage(widget.floorTexture),
                        repeat: ImageRepeat.repeat,
                      ),
                    ),
                  ),
                ),

                /* Left wall */
                PositionedDirectional(
                  top: 0,
                  start: _extraSpace,
                  child: Transform(
                    alignment: Alignment.topLeft,
                    transform: Matrix4.identity()..rotateY(-math.pi / 2),
                    child: SizedBox(
                      width: widget.height,
                      height: widget.length,
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
                          width: widget.width,
                          height: widget.height,
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

                /* Items */
                for (Furniture furniture in widget.items) ...[
                  FurnitureCard(furniture: furniture),
                ],
                for (Slot slot in widget.slots) ...[
                  slot.item == null
                      ? FurnitureSlot(slot: slot)
                      : FurnitureCard(
                          furniture: slot.items
                              .firstWhere((item) => item.name == slot.item),
                        ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
