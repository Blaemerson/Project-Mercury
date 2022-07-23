import 'package:flutter/material.dart';
import 'package:projectmercury/models/slot.dart';
import 'package:projectmercury/pages/homePage/isometric.dart';
import 'package:projectmercury/pages/storePage/store_page.dart';

class Indicator extends StatelessWidget {
  const Indicator({
    Key? key,
    required this.link,
    required this.offset,
  }) : super(key: key);

  final LayerLink link;
  final Offset offset;

  @override
  Widget build(BuildContext context) {
    return CompositedTransformFollower(
      offset: offset,
      link: link,
      child: Container(
        height: 50,
        width: 59,
        color: Colors.green,
      ),
    );
  }
}

class SlotCard extends StatelessWidget {
  final Slot slot;
  final String roomName;
  const SlotCard({Key? key, required this.slot, required this.roomName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LayerLink layerLink = LayerLink();
    /* Overlay.of(context).insert(overlayEntry); */

    return Positioned(
      top: slot.position.dx,
      right: slot.position.dy,
      height: slot.height,
      child: Transform(
        transform: Matrix4.translationValues(0, 0, slot.zPosition),
        child: Actor(
          alignment: Alignment.center,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
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
