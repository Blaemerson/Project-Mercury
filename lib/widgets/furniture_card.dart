import 'package:flutter/material.dart';
import 'package:projectmercury/models/furniture_slot.dart';
import 'package:projectmercury/widgets/cube.dart';
import 'package:projectmercury/widgets/isometric.dart';

/// Creates a card to display furniture.
class FurnitureCard extends StatelessWidget {
  final FurnitureSlot furniture;
  const FurnitureCard({
    Key? key,
    required this.furniture,
  }) : super(key: key);

  // TODO: make furniture slots touchable, bring up shop with different options (and/or variants of item)?.
  @override
  Widget build(BuildContext context) {
    const bool _debugBox = false;
    return Container(
      decoration: BoxDecoration(
        color: _debugBox ? Colors.red : Colors.transparent,
        border: furniture.item == null ? Border.all(color: Colors.black) : null,
      ),
      width: furniture.width,
      height: furniture.height + (furniture.item == 'paintingRooster' ? 30 : 0),
      child: Actor(
        child: furniture.item != null
            ? Image.asset(
                'assets/furniture/${furniture.item}.png',
                alignment: AlignmentDirectional.center,
                scale: 3,
              )
            : Container(),
        /* ['bed', 'chair', 'sofa', 'refridgerator', 'rug'] */
        /*               .contains(furniture.type) */
        /*           ? Image.asset( */
        /*               // TODO: make outlines for each selectable furniture */
        /*               'assets/furniture/livingroom/${furniture.type}_outline.png', */
        /*               alignment: AlignmentDirectional.center, */
        /*               height: furniture.height, */
        /*               width: furniture.width, */
        /*             ) */
        /*           : Container(), */
      ),
    );
  }
}
