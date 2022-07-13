import 'package:flutter/material.dart';
import 'package:projectmercury/models/slot.dart';
import 'package:projectmercury/pages/homePage/cube.dart';
import 'package:projectmercury/pages/storePage/store_page.dart';

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
