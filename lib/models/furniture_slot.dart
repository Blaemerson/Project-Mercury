import 'package:flutter/material.dart';
import 'package:projectmercury/pages/storePage/store_page.dart';
import 'package:projectmercury/widgets/cube.dart';
import 'package:projectmercury/widgets/furniture_card.dart';
import 'dart:math' as math;

class FurnitureSlot extends StatelessWidget {
  final String room;
  final double width;
  final double length;
  final double height;
  final double yPosition;
  final double xPosition;
  final num overchargeRate; // hardcode transaction overcharge
  final bool doubleCharge; // item charged twice (overrides overchargeRate)
  String? item;
  final List<FurnitureCard> items;

  FurnitureSlot({
    Key? key,
    required this.width,
    required this.height,
    required this.yPosition,
    required this.xPosition,
    required this.items,
    required this.length,
    required this.room,
    this.overchargeRate = 0,
    this.doubleCharge = false,
  }) : super(key: key);

  set(String? item) {
    this.item = item;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: yPosition,
      bottom: xPosition,
      child: Transform(
        transform: Matrix4.identity(),
        alignment: Alignment.center,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => showModalBottomSheet(
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
                items: items.map((e) => e.name).toList(),
                slot: this,
                room: room,
              );
            },
          ),
          child: Cube(width: width, height: length, depth: height),
        ),
      ),
    );
  }
}

/// Creates a slot for furniture to be placed in a room.
/* class FurnitureSlot { */
/*   final double width; */
/*   final double height; */
/*   final double yPosition; */
/*   final double xPosition; */
/*   final List<String> possibleItems; */
/*   String? item; */
/*   FurnitureSlot({ */
/*     required this.width, */
/*     required this.height, */
/*     required this.yPosition, */
/*     required this.xPosition, */
/*     this.possibleItems = const <String>[], */
/*     this.item, */
/*   }); */
/**/
/*   set(String? item) { */
/*     this.item = item; */
/*   } */
/* } */
