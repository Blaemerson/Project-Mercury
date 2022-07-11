import 'package:flutter/material.dart';
import 'package:projectmercury/widgets/isometric.dart';

/// Creates a card to display furniture.
class FurnitureCard extends StatelessWidget {
  final String name;
  final double xPosition;
  final double yPosition;
  final double width;
  final double height;
  const FurnitureCard({
    Key? key,
    required this.name,
    required this.xPosition,
    required this.yPosition,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: yPosition,
      bottom: xPosition,
      child: Actor(
        child: Image.asset(
          'assets/furniture/$name.png',
          width: width,
          height: height,
        ),
      ),
    );
  }
}
