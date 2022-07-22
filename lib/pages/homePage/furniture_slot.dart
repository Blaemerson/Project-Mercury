import 'package:flutter/material.dart';
import 'package:projectmercury/models/slot.dart';
import 'package:projectmercury/pages/homePage/isometric.dart';
import 'package:projectmercury/pages/storePage/store_page.dart';

class SlotCard extends StatelessWidget {
  final Slot slot;
  final String roomName;
  const SlotCard({Key? key, required this.slot, required this.roomName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: slot.position.dx,
      right: slot.position.dy,
      width: slot.size.width,
      height: slot.size.height,
      child: Transform(
        transform: Matrix4.translationValues(0, 0, slot.zPosition),
        child: Actor(
          alignment: Alignment.center,
          child: GestureDetector(
            behavior: HitTestBehavior.deferToChild,
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
            child: Image.asset('assets/furniture/${slot.visual}.png'),
          ),
        ),
      ),
    );
  }
}
// Builds the furniture slot
