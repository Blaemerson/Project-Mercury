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
      width: furniture.size != null ? furniture.size!.width : slot!.size.width,
      height:
          furniture.size != null ? furniture.size!.height : slot!.size.height,
      child: Transform(
        transform: Matrix4.translationValues(
            0, 0, furniture.zPosition ?? slot!.zPosition),
        child: Actor(
          alignment: Alignment.center,
          child: Image.asset(
              'assets/furniture/${furniture.name}_${furniture.direction}.png'),
        ),
      ),
    );
  }
}

/// Creates a card to display furniture.
