import 'package:flutter/material.dart';
import 'package:projectmercury/widgets/isometric.dart';

// Holds data relating to furniture
class Furniture {
  final String name;
  final double xPosition;
  final double yPosition;
  final double width;
  final double height;

  const Furniture({
    required this.name,
    required this.xPosition,
    required this.yPosition,
    required this.width,
    required this.height,
  });
}

/// Creates a card to display furniture.
class FurnitureCard extends StatelessWidget {
  final Furniture furniture;
  const FurnitureCard({
    Key? key,
    required this.furniture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: furniture.yPosition,
      bottom: furniture.xPosition,
      child: Actor(
        child: Image.asset(
          'assets/furniture/${furniture.name}.png',
          width: furniture.width,
          height: furniture.height,
        ),
      ),
    );
  }
}
