import 'package:flutter/material.dart';
import 'package:projectmercury/models/furniture.dart';
import 'package:projectmercury/pages/homePage/isometric.dart';


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
