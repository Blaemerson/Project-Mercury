/// This widget builds a room in true isometric perspective/
/// On building, occupied and unoccupied items slots are additionally loaded in.
/// Heavily relies on Flutter's stack widget to overlay/position room components/items.

import 'package:flutter/material.dart';
/* import 'package:projectmercury/models/items.dart'; */
/* import 'package:projectmercury/models/slot.dart'; */
import 'dart:math' as math;

import 'package:projectmercury/models/store_item.dart';
/* import 'package:projectmercury/pages/homePage/items_card.dart'; */
/* import 'package:projectmercury/pages/homePage/items_slot.dart'; */
import 'package:projectmercury/pages/homePage/isometric.dart';
import 'package:projectmercury/pages/storePage/store_page.dart';
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
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: FittedBox(
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
                              image:
                                  AssetImage('assets/textures/darkPlanks.jpg'),
                              repeat: ImageRepeat.repeat,
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
                            transform: Matrix4.identity()
                              ..rotateY(-math.pi / 2),
                            child: RotatedBox(
                              quarterTurns: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(color: Colors.brown),
                                  image: DecorationImage(
                                    alignment: Alignment.topLeft,
                                    opacity: widget.roomBehind ? 0.5 : 1.0,
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
                            transform: Matrix4.identity()
                              ..rotateX(-math.pi / 2),
                            transformAlignment: Alignment.bottomCenter,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: Colors.brown),
                                image: DecorationImage(
                                  alignment: Alignment.topLeft,
                                  opacity: widget.roomBeside ? 0.5 : 1.0,
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
                                transform: Matrix4.translationValues(
                                    0, 0, s.zPosition),
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
      ),
    );
  }
}

/* class Room extends StatefulWidget { */
/*   final String name; // Name of this room ("bedroom", "livingroom", ...) */
/*   final int unlockOrder; // Session number on which users unlock this room. */
/*   final List<Furniture> */
/*       items; // List of items to be loaded into room initially. */
/*   final List<Slot> */
/*       slots; // Slots that appear empty and must have their item purchased to appear. */
/*   final String floorTexture; // Path to asset used for wall texture. */
/*   final String wallTexture; // Path to asset used for floor texture. */
/*   final double */
/*       width; // Width of room; visually, distance from back-left wall to front-right wall */
/*   final double */
/*       length; // Length of room; visually, distance from back-right wall to front-left wall */
/*   final double height; // Height of walls */
/**/
/*   // 300 is the max width/length for a room, to avoid wall displacement and other deformaties */
/*   const Room({ */
/*     Key? key, */
/*     required this.items, */
/*     required this.width, */
/*     required this.length, */
/*     this.height = 90, */
/*     required this.name, */
/*     required this.unlockOrder, */
/*     required this.floorTexture, */
/*     required this.wallTexture, */
/*     required this.slots, */
/*   })  : assert(width <= 300 && length <= 300), */
/*         super(key: key); */
/**/
/*   @override */
/*   State<Room> createState() => _RoomState(); */
/* } */
/**/
/* class _RoomState extends State<Room> { */
/*   // Items need extra space inside the Stack to get close to the walls, may need tweaking */
/*   final _extraSpace = 80.0; */
/**/
/*   @override */
/*   Widget build(BuildContext context) { */
/*     return IsometricView( */
/*       child: SizedBox( */
/*         width: widget.width + _extraSpace, */
/*         height: widget.length + _extraSpace, */
/*         child: StreamBuilder<List<PurchasedItem>>( */
/*           stream: */
/*               locator.get<FirestoreMethods>().itemsStream(room: widget.name), */
/*           builder: (context, roomItems) { */
/*             return Stack( */
/*               alignment: AlignmentDirectional.bottomEnd, */
/*               clipBehavior: Clip.none, */
/*               children: [ */
/*                 /* Floor */ */
/*                 PositionedDirectional( */
/*                   top: 0, */
/*                   end: 0, */
/*                   child: Container( */
/*                     width: widget.width, */
/*                     height: widget.length, */
/*                     decoration: BoxDecoration( */
/*                       border: Border.all(color: Colors.brown), */
/*                       image: DecorationImage( */
/*                         image: AssetImage(widget.floorTexture), */
/*                         repeat: ImageRepeat.repeat, */
/*                       ), */
/*                     ), */
/*                   ), */
/*                 ), */
/**/
/*                 /* Left wall */ */
/*                 PositionedDirectional( */
/*                   top: 0, */
/*                   start: _extraSpace, */
/*                   child: Transform( */
/*                     alignment: Alignment.topLeft, */
/*                     transform: Matrix4.identity()..rotateY(-math.pi / 2), */
/*                     child: SizedBox( */
/*                       width: widget.height, */
/*                       height: widget.length, */
/*                       child: RotatedBox( */
/*                         quarterTurns: 1, */
/*                         child: Container( */
/*                           decoration: BoxDecoration( */
/*                             color: Colors.transparent, */
/*                             border: Border.all(color: Colors.brown), */
/*                             image: DecorationImage( */
/*                               alignment: Alignment.topLeft, */
/*                               opacity: .75, */
/*                               image: AssetImage(widget.wallTexture), */
/*                               repeat: ImageRepeat.repeat, */
/*                             ), */
/*                           ), */
/*                         ), */
/*                       ), */
/*                     ), */
/*                   ), */
/*                 ), */
/**/
/*                 /* Right wall */ */
/*                 PositionedDirectional( */
/*                   bottom: _extraSpace, */
/*                   end: 0, */
/*                   child: Transform( */
/*                     alignment: Alignment.bottomCenter, */
/*                     transform: Matrix4.identity()..rotateX(-math.pi / 2), */
/*                     child: Stack( */
/*                       children: [ */
/*                         Container( */
/*                           width: widget.width, */
/*                           height: widget.height, */
/*                           decoration: BoxDecoration( */
/*                             border: Border.all(color: Colors.brown), */
/*                             image: DecorationImage( */
/*                               opacity: .75, */
/*                               image: AssetImage(widget.wallTexture), */
/*                               repeat: ImageRepeat.repeat, */
/*                             ), */
/*                           ), */
/*                         ), */
/*                       ], */
/*                     ), */
/*                   ), */
/*                 ), */
/**/
/*                 /* Items */ */
/*                 for (Furniture items in widget.items) ...[ */
/*                   FurnitureCard(items: items), */
/*                 ], */
/*                 for (Slot slot in widget.slots) ...[ */
/*                   slot.item == null */
/*                       ? FurnitureSlot(slot: slot) */
/*                       : FurnitureCard( */
/*                           items: slot.items */
/*                               .firstWhere((item) => item.name == slot.item), */
/*                         ), */
/*                 ], */
/*               ], */
/*             ); */
/*           }, */
/*         ), */
/*       ), */
/*     ); */
/*   } */
/* } */
