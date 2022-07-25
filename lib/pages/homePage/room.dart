import 'package:flutter/material.dart';
import 'package:projectmercury/models/furniture.dart';
import 'package:projectmercury/models/slot.dart';
import 'dart:math' as math;

import 'package:projectmercury/models/store_item.dart';
import 'package:projectmercury/pages/homePage/furniture_card.dart';
import 'package:projectmercury/pages/homePage/slot_card.dart';
import 'package:projectmercury/pages/homePage/isometric.dart';
import 'package:projectmercury/resources/event_controller.dart';
import 'package:projectmercury/resources/firestore_methods.dart';
import 'package:projectmercury/resources/locator.dart';

class Room extends StatefulWidget {
  final String name;
  final int unlockOrder;
  final double width;
  final double length;
  final double height;
  final bool roomBehind;
  final bool roomBeside;
  final List<Object?> items;
  /* final List<Furniture> furniture; */
  /* final List<Slot> slots; */
  const Room(
      {Key? key,
      required this.unlockOrder,
      required this.width,
      required this.length,
      required this.height,
      this.name = '',
      this.roomBehind = false,
      this.roomBeside = false,
      this.items = const []
      /* this.furniture = const [], */
      /* this.slots = const [], */
      })
      : super(key: key);

  @override
  State<Room> createState() => _RoomState();

  Iterable<Slot> get slots => items.whereType<Slot>();
  // Fill all items matching a given ID with a given item
  Iterable<Slot> slotsByID(int slotID) => slots.where((s) => s.id == slotID);
  fillSlots(int? slotID, String? item) {
    slots
        .where((s) => slotID == null ? true : s.id == slotID)
        .forEach((s) => s.set(item));
  }

  Iterable<Slot> get filledSlots =>
      items.whereType<Slot>().where((s) => s.item != null);
  get furniture => items.whereType<Furniture>();
}

class _RoomState extends State<Room> {
  @override
  Widget build(BuildContext context) {
    Room? _currentRoom = locator.get<EventController>().currentRoom;
    bool shouldFadeWalls = _currentRoom == null;
    return FittedBox(
      child: IsometricView(
        child: SizedBox(
          width: widget.length + widget.height,
          height: widget.width + widget.height,
          child: StreamBuilder<List<PurchasedItem>>(
            stream:
                locator.get<FirestoreMethods>().itemsStream(room: widget.name),
            builder: (context, roomItems) {
              List<Widget> placeables = [];

              for (Object? o in widget.items) {
                if (o is Slot) {
                  if (o.item != null) {
                    if (roomItems.data!.map((e) => e.item).contains(o.item)) {
                      placeables.add(FurnitureCard(
                        furniture: o.acceptables.firstWhere(
                          (element) => element.name == o.item,
                        ),
                        slot: o,
                      ));
                    }
                  } else if (_currentRoom != null &&
                      o.item == null &&
                      o.owned == false) {
                    if (o.prereq == null ||
                        widget.filledSlots
                            .toSet()
                            .intersection(widget.slotsByID(o.prereq!).toSet())
                            .isNotEmpty) {
                      placeables.add(SlotCard(slot: o, roomName: widget.name));
                    }
                  }
                } else if (o is Furniture) {
                  placeables.add(FurnitureCard(furniture: o));
                }
              }
              return Stack(
                clipBehavior: Clip.none,
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
                  Positioned(
                    top: 0,
                    left: 0,
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
                  for (Widget item in placeables) item,
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
