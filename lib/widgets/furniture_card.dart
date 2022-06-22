import 'package:flutter/material.dart';
import 'package:projectmercury/models/furniture_slot.dart';

class FurnitureCard extends StatelessWidget {
  final FurnitureSlot furniture;
  const FurnitureCard({
    Key? key,
    required this.furniture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // show container boundaries
    bool _debugBox = false;
    return Positioned(
      width: furniture.width,
      height: furniture.height,
      left: furniture.positionX,
      bottom: furniture.positionY,
      child: furniture.variant != null
          ? Container(
              color: _debugBox
                  ? const Color.fromARGB(67, 255, 7, 7)
                  : Colors.transparent,
              child: Image(
                image: AssetImage(
                    'assets/furniture/${furniture.type + furniture.variant!}.png'),
              ),
            )
            // TODO: make outlines for each selectable furniture
          : ['bed', 'chair', 'couch', 'refridgerator'].contains(furniture.type)? Container(
              color: _debugBox
                  ? const Color.fromARGB(67, 255, 7, 7)
                  : Colors.transparent,
              child: Image(
                color: Color.fromARGB(128, 0, 0, 0),
                image: AssetImage(
                    'assets/furniture/${furniture.type}_outline.png'),
              ),
            ):Container(),
    );
  }
}
