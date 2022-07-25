import 'package:flutter/material.dart';
import 'package:projectmercury/models/slot.dart';
import 'package:projectmercury/pages/storePage/store_page.dart';
import 'dart:math' as math;

class SlotCard extends StatelessWidget {
  final Slot slot;
  final String roomName;
  const SlotCard({Key? key, required this.slot, required this.roomName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: slot.position.dx - 20,
      right: slot.position.dy,
      child: Transform(
        transform: Matrix4.rotationZ(45 * math.pi / 180),
        alignment: Alignment.center,
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
                  roomName: roomName,
                  slot: slot,
                );
              },
            );
          },
          child: SizedBox(
            height: slot.height + 50,
            child: UnconstrainedBox(
              child: Transform(
                transform: Matrix4.identity()
                  ..rotateX(-(90 - 35.264) * math.pi / 180),
                alignment: Alignment.center,
                child: Image.asset('assets/furniture/${slot.visual}.png',
                    height: slot.height),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
// Builds the furniture slot
