import 'package:flutter/material.dart';
import 'package:projectmercury/models/furniture_slot.dart';

/// Creates a card to display furniture.
class FurnitureCard extends StatelessWidget {
  final FurnitureSlot furniture;
  const FurnitureCard({
    Key? key,
    required this.furniture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const bool _debugBox = false;
    return Container(
      color: _debugBox ? Colors.red : Colors.transparent,
      child: furniture.variant != null
          ? Image.asset(
              'assets/furniture/${furniture.type + furniture.variant!}.png',
              alignment: AlignmentDirectional.center,
              height: furniture.height,
              width: furniture.width,
            )
          : ['bed', 'chair', 'sofa', 'refridgerator', 'rug'].contains(furniture.type)
              ? Image.asset(
                  // TODO: make outlines for each selectable furniture
                  'assets/furniture/${furniture.type}_outline.png',
                  alignment: AlignmentDirectional.center,
                  height: furniture.height,
                  width: furniture.width,
                )
              : Container(),
    );
  }
}
