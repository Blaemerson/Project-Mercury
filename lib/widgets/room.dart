import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:projectmercury/models/store_item.dart';
import 'package:projectmercury/pages/storePage/store_page.dart';
import 'package:projectmercury/resources/firestore_methods.dart';
import 'package:projectmercury/resources/locator.dart';
import 'package:projectmercury/widgets/furniture_card.dart';
import 'package:projectmercury/models/furniture_slot.dart';
import 'package:projectmercury/widgets/isometric.dart';

class Furniture extends StatelessWidget {
  final double xPosition;
  final double yPosition;
  final Size size;
  final String name;
  const Furniture({
    Key? key,
    required this.xPosition,
    required this.yPosition,
    required this.name,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: xPosition,
      top: yPosition,
      child: Container(
        transform: Matrix4.identity()
          ..rotateZ(-45 * math.pi / 180)
          ..rotateX(-35.264 * math.pi / 180),
        transformAlignment: Alignment.center,
        height: size.height,
        width: size.width,
        child: Image.asset('assets/furniture/$name.png'),
      ),
    );
  }
}

class Slot extends StatefulWidget {
  final double width;
  final double length;
  final double height;
  final double xPosition;
  final double yPosition;
  final List<Widget> items;
  bool _purchased = false;
  Slot({
    Key? key,
    required this.width,
    required this.length,
    required this.height,
    required this.xPosition,
    required this.yPosition,
    required this.items,
  }) : super(key: key);

  @override
  State<Slot> createState() => _SlotState();
}

class _SlotState extends State<Slot> {
  @override
  Widget build(BuildContext context) {
    return widget._purchased == false
        ? Positioned(
            left: widget.xPosition,
            top: widget.yPosition,
            child: Container(
              transform: Matrix4.identity()
                ..rotateX(math.pi)
                ..rotateZ(90 * math.pi / 180),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => setState(() {
                  widget._purchased = true;
                }),
                child: Stack(
                  children: [
                    Container(
                      width: widget.height,
                      height: widget.length,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        color: const Color.fromARGB(220, 200, 200, 200),
                      ),
                      transform: Matrix4.identity()
                        ..rotateY(-90 * math.pi / 180),
                    ),
                    Container(
                      width: widget.width,
                      height: widget.height,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        color: const Color.fromARGB(220, 200, 200, 200),
                      ),
                      transform: Matrix4.identity()
                        ..rotateX(90 * math.pi / 180),
                    ),
                    Container(
                      width: widget.width,
                      height: widget.length,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        color: const Color.fromARGB(220, 200, 200, 200),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : widget.items[1];
  }
}

class Wall extends StatelessWidget {
  final double roomWidth;
  final double roomLength;
  final double roomHeight;
  final String leftOrRight;
  const Wall(
      {Key? key,
      required this.roomWidth,
      required this.roomLength,
      required this.roomHeight,
      required this.leftOrRight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Container(
        width: leftOrRight == 'right' ? roomWidth : roomHeight,
        height: leftOrRight == 'right' ? roomHeight : roomLength,
        color: leftOrRight == 'right' ? Colors.pink : Colors.purple,
        transform: leftOrRight == 'right'
            ? (Matrix4.identity()..rotateX(90 * math.pi / 180))
            : (Matrix4.identity()..rotateY(-90 * math.pi / 180)),
      ),
    );
  }
}

class Floor extends StatelessWidget {
  final String name;
  final double width;
  final double length;
  final double height;
  const Floor({
    Key? key,
    required this.width,
    required this.length,
    required this.height,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      transform: Matrix4.identity()
        ..rotateX((90 - 35.264) * math.pi / 180)
        ..rotateZ(45 * math.pi / 180),
      transformAlignment: Alignment.center,
      width: width,
      height: length,
      color: Colors.grey,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Wall(
            leftOrRight: 'right',
            roomLength: length,
            roomWidth: width,
            roomHeight: height,
          ),
          Wall(
            leftOrRight: 'left',
            roomLength: length,
            roomWidth: width,
            roomHeight: height,
          ),
          Slot(
            xPosition: 40,
            yPosition: 40,
            width: 70,
            length: 70,
            height: 40,
            items: const [
              Furniture(
                xPosition: -10,
                yPosition: -10,
                name: 'bed1',
                size: Size(80, 80),
              ),
              Furniture(
                xPosition: 10,
                yPosition: 20,
                name: 'rugBear',
                size: Size(100, 100),
              )
            ],
          )
        ],
      ),
    );
  }
}

class Room extends StatelessWidget {
  final String name;
  final int unlockOrder;
  final List<FurnitureSlot> items;
  // TODO: make wall/flooring changable
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
      child: Container(
        /* color: Colors.blue, */
        width: extendLeft + _extraSpace,
        height: extendRight + _extraSpace,
        child: StreamBuilder<List<PurchasedItem>>(
            stream: locator.get<FirestoreMethods>().itemsStream(room: name),
            builder: (context, roomItems) {
              if (roomItems.hasData) {
                // reset then place items in room
                for (FurnitureSlot slot in items) {
                  if (slot.item != '' && slot.possibleItems.isNotEmpty) {
                    slot.set(null);
                  }
                }
                for (PurchasedItem purchase in roomItems.data!) {
                  List<FurnitureSlot> matchingSlot = items
                      .where(
                          (slot) => slot.possibleItems.contains(purchase.item))
                      .toList();
                  matchingSlot.isNotEmpty
                      ? matchingSlot.first.set(purchase.item)
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
                      child: slot.item == null
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
                                        room: this,
                                        slotItems: slot.possibleItems);
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
