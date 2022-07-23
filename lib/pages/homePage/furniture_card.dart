import 'package:flutter/material.dart';
import 'package:projectmercury/models/furniture.dart';
import 'package:projectmercury/models/slot.dart';
import 'package:projectmercury/pages/homePage/isometric.dart';

class FurnitureCard extends StatelessWidget {
  final Furniture furniture;
  final Slot? slot;

  const FurnitureCard({
    Key? key,
    required this.furniture,
    this.slot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: furniture.position != null
          ? furniture.position!.dx
          : slot!.position.dx,
      right: furniture.position != null
          ? furniture.position!.dy
          : slot!.position.dy,
      child: Transform(
        transform: Matrix4.translationValues(
            0, 0, furniture.zPosition ?? (slot == null ? 0 : slot!.zPosition)),
        child: Actor(
          alignment: Alignment.center,
          child: furniture.direction != null
              ? Image.asset(
                  'assets/furniture/${furniture.name}_${furniture.direction}.png',
                  height: furniture.height ?? slot!.height,
                )
              : Image.asset(
                  'assets/furniture/${furniture.name}.png',
                  height: furniture.height ?? slot!.height,
                ),
        ),
      ),
    );
  }
}

/// Creates a card to display furniture.
