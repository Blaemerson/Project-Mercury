import 'package:flutter/material.dart';
import 'package:projectmercury/pages/storePage/store_page.dart';
import 'package:projectmercury/widgets/cube.dart';
import 'package:projectmercury/widgets/furniture_card.dart';

// Holds data relating to furniture slot
class Slot {
  final String room;
  final double width;
  final double length;
  final double height;
  final double yPosition;
  final double xPosition;
  final num overchargeRate; // hardcode transaction overcharge
  final bool doubleCharge; // item charged twice (overrides overchargeRate)
  String? item;
  final List<Furniture> items;

  Slot({
    required this.room,
    required this.width,
    required this.length,
    required this.height,
    required this.yPosition,
    required this.xPosition,
    this.overchargeRate = 0,
    this.doubleCharge = false,
    required this.items,
  });

  set(String? item) {
    this.item = item;
  }
}

// Builds the furniture slot
class FurnitureSlot extends StatelessWidget {
  final Slot slot;

  const FurnitureSlot({
    Key? key,
    required this.slot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: slot.yPosition,
      bottom: slot.xPosition,
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
                room: slot.room,
                slot: slot,
              );
            },
          ),
          child: Cube(
            width: slot.width,
            height: slot.length,
            depth: slot.height,
          ),
        ),
      ),
    );
  }
}
