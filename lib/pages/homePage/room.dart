/// This widget builds a room in true isometric perspective/
/// On building, occupied and unoccupied items slots are additionally loaded in.
/// Heavily relies on Flutter's stack widget to overlay/position room components/items.

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:projectmercury/models/store_item.dart';
import 'package:projectmercury/pages/homePage/isometric.dart';
import 'package:projectmercury/pages/storePage/store_page.dart';
import 'package:projectmercury/resources/event_controller.dart';
import 'package:projectmercury/resources/firestore_methods.dart';
import 'package:projectmercury/resources/locator.dart';

class Slot {
  final int id;
  final Size size;
  final Offset position;
  final double zPosition;
  final List<String> acceptables;
  final String? outline;
  final double overchargeRate;
  final bool delay;
  final bool doubleCharge;
  String? item;

  Slot({
    required this.id,
    required this.size,
    required this.acceptables,
    required this.position,
    this.item,
    this.overchargeRate = 0,
    this.delay = false,
    this.doubleCharge = false,
    this.zPosition = 0,
    this.outline,
  });
  set(String? item) => this.item = item;
}

class Furniture {
  final String name;
  final Size size;
  final Offset position;
  final double zPosition;
  final String? direction;
  final int slotID;

  const Furniture({
    required this.name,
    required this.position,
    required this.size,
    this.zPosition = 0,
    this.direction,
    this.slotID = -1,
  });
}

class Room extends StatefulWidget {
  final String name;
  final int unlockOrder;
  final double width;
  final double length;
  final double height;
  final bool roomBehind;
  final bool roomBeside;
  final List<Furniture> furniture;
  final List<Slot> slots;
  const Room({
    Key? key,
    required this.unlockOrder,
    required this.width,
    required this.length,
    required this.height,
    this.name = '',
    this.roomBehind = false,
    this.roomBeside = false,
    this.furniture = const [],
    this.slots = const [],
  }) : super(key: key);

  @override
  State<Room> createState() => _RoomState();
}

class _RoomState extends State<Room> {
  @override
  Widget build(BuildContext context) {
    Room? _currentRoom = locator.get<EventController>().currentRoom;
    bool shouldFadeWalls = _currentRoom == null;
    return FittedBox(
      child: Transform(
        transform: Matrix4.identity()
          ..rotateX((90 - 35.264) * math.pi / 180)
          ..rotateZ(-math.pi / 4),
        alignment: Alignment.center,
        child: SizedBox(
          width: widget.length + widget.height,
          height: widget.width + widget.height,
          child: StreamBuilder<List<PurchasedItem>>(
              stream: locator
                  .get<FirestoreMethods>()
                  .itemsStream(room: widget.name),
              builder: (context, roomItems) {
                return Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        width: widget.length,
                        height: widget.width,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.brown),
                          image: const DecorationImage(
                            image: AssetImage('assets/textures/darkPlanks.jpg'),
                            fit: BoxFit.none,
                            repeat: ImageRepeat.repeatY,
                          alignment: Alignment.topLeft,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        child: Container(
                          width: widget.height,
                          height: widget.width,
                          transform: Matrix4.identity()..rotateY(-math.pi / 2),
                          child: RotatedBox(
                            quarterTurns: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: Colors.brown),
                                image: DecorationImage(
                                  alignment: Alignment.topLeft,
                                  opacity: widget.roomBehind && shouldFadeWalls
                                      ? 0.3
                                      : 1.0,
                                  image: const AssetImage(
                                      'assets/textures/greenWall.jpg'),
                                  repeat: ImageRepeat.repeat,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        child: Container(
                          width: widget.length,
                          height: widget.height,
                          transform: Matrix4.identity()..rotateX(-math.pi / 2),
                          transformAlignment: Alignment.bottomCenter,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.brown),
                              image: DecorationImage(
                                alignment: Alignment.topLeft,
                                opacity: widget.roomBeside && shouldFadeWalls
                                    ? 0.3
                                    : 1.0,
                                image: const AssetImage(
                                    'assets/textures/greenWall.jpg'),
                                repeat: ImageRepeat.repeat,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    for (Furniture f in widget.furniture)
                      // Find the slot corresponding to this items id
                      if (f.slotID == -1 ||
                          (widget.slots
                                  .firstWhere(
                                      (element) => f.slotID == element.id)
                                  .item ==
                              f.name))
                        Positioned(
                          top: f.position.dx,
                          right: f.position.dy,
                          width: f.size.width,
                          height: f.size.height,
                          child: Transform(
                            transform:
                                Matrix4.translationValues(0, 0, f.zPosition),
                            child: Actor(
                              alignment: Alignment.center,
                              child: Image.asset(
                                  'assets/furniture/${f.name}_${f.direction}.png'),
                            ),
                          ),
                        ),
                    for (Slot s in widget.slots)
                      if (s.item == null)
                        Positioned(
                          top: s.position.dx,
                          right: s.position.dy,
                          width: s.size.width,
                          height: s.size.height,
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
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
                                    roomName: widget.name,
                                    slot: s,
                                  );
                                },
                              );
                            },
                            child: Transform(
                              transform:
                                  Matrix4.translationValues(0, 0, s.zPosition),
                              child: Actor(
                                alignment: Alignment.center,
                                child: Image.asset(
                                    'assets/furniture/${s.outline}.png'),
                              ),
                            ),
                          ),
                        )
                  ],
                );
              }),
        ),
      ),
    );
  }
}
