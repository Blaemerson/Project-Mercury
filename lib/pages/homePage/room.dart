import 'package:flutter/material.dart';
import 'package:projectmercury/models/furniture.dart';
import 'package:projectmercury/models/slot.dart';
import 'dart:math' as math;

import 'package:projectmercury/models/store_item.dart';
import 'package:projectmercury/pages/homePage/furniture_card.dart';
import 'package:projectmercury/pages/homePage/furniture_slot.dart';
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

  // Fill all items matching a given ID with a given item
  setSlotItems(int? slotID, String? item) {
    slots
        .where((element) => slotID == null ? true : element.id == slotID)
        .forEach((element) {
      element.set(item);
    });
  }

  List<Slot> getSlots(int slotID) =>
      slots.where((s) => s.id == slotID).toList();
  getFilledSlots() => slots.where((s) => s.item != null).toList();
  getFurniture(int slotID) =>
      furniture.where((f) => f.slotID == slotID).toList();
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
                      if (f.slotID != null)
                        for (Slot s in widget.getSlots(f.slotID!))
                          /* Container(height: s.size.height), */
                          if (s.item == f.name)
                            FurnitureCard(furniture: f, slot: s),
                    for (Furniture f in widget.furniture)
                      if (f.slotID == null) FurnitureCard(furniture: f),
                    // Hide slots when in full view
                    if (_currentRoom != null)
                      for (Slot s in widget.slots)
                        // if the slot is not filled...
                        if (s.item == null)
                          // if slot has no unfinished prerequisites...
                          if (s.prereq == null ||
                              widget
                                  .getFilledSlots()
                                  .contains(widget.getSlots(s.prereq!)))
                            SlotCard(slot: s, roomName: widget.name)
                  ],
                );
              }),
        ),
      ),
    );
  }
}
