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

class Room extends StatelessWidget {
  final String name;
  final int unlockOrder;
  final double width;
  final double length;
  final double height;
  final bool roomBehind;
  final bool roomBeside;
  final List<Object?> items;
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
      })
      : super(key: key);

  Iterable<Slot> get slots => items.whereType<Slot>();
  // Fill all items matching a given ID with a given item
  Iterable<Slot> slotsByID(int slotID) => slots.where((s) => s.id == slotID);
  fillSlots(int? slotID, String? item) {
    slots.where((s) => slotID == null ? true : s.id == slotID).forEach((s) {
      s.set(item);
    });
  }

  Iterable<Slot> get filledSlots =>
      items.whereType<Slot>().where((s) => s.item != null);
  get furniture => items.whereType<Furniture>();

  @override
  Widget build(BuildContext context) {
    Room? _currentRoom = locator.get<EventController>().currentRoom;
    bool shouldFadeWalls = _currentRoom == null;
    return FittedBox(
      child: IsometricView(
        child: SizedBox(
          width: length + height,
          height: width + height,
          child: StreamBuilder<List<PurchasedItem>>(
            stream: locator.get<FirestoreMethods>().itemsStream(room: name),
            builder: (context, roomItems) {
              List<Widget> placeables = [];
              bool _shouldShowSlots = roomItems.data!.where((element) => element.delivered == false).isEmpty;
              for (Object? o in items) {
                if (o is Slot) {
                  if (o.item != null) {
                    placeables.add(FurnitureCard(
                      furniture: o.acceptables.firstWhere(
                        (element) => element.name == o.item,
                      ),
                      slot: o,
                    ));
                  } else if (_currentRoom != null &&
                      o.item == null &&
                      _shouldShowSlots) {
                    if (o.prereq == null ||
                        filledSlots
                            .toSet()
                            .intersection(slotsByID(o.prereq!).toSet())
                            .isNotEmpty) {
                      placeables.add(SlotCard(slot: o, roomName: name));
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
                      width: length,
                      height: width,
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
                    child: IgnorePointer(
                      ignoring: _currentRoom == null ? true : false,
                      child: Container(
                        width: height,
                        height: width,
                        transform: Matrix4.identity()..rotateY(-math.pi / 2),
                        child: RotatedBox(
                          quarterTurns: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.brown),
                              image: DecorationImage(
                                alignment: Alignment.topLeft,
                                opacity:
                                    roomBehind && shouldFadeWalls ? 0.3 : 1.0,
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
                    child: IgnorePointer(
                      ignoring: _currentRoom == null ? true : false,
                      child: Container(
                        width: length,
                        height: height,
                        transform: Matrix4.identity()..rotateX(-math.pi / 2),
                        transformAlignment: Alignment.bottomCenter,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.brown),
                            image: DecorationImage(
                              alignment: Alignment.topLeft,
                              opacity:
                                  roomBeside && shouldFadeWalls ? 0.3 : 1.0,
                              image: const AssetImage(
                                  'assets/textures/greenWall.jpg'),
                              repeat: ImageRepeat.repeat,
                            ),
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
