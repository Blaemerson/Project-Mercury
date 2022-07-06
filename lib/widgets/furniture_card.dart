import 'package:flutter/material.dart';
import 'package:projectmercury/models/furniture_slot.dart';
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
      // TODO: Handle furniture placement better.
      decoration: BoxDecoration(
        color: furniture.item == null ? const Color.fromARGB(100, 255, 255, 255) : null,
        border: furniture.item == null ? Border.all(color: Colors.black) : null,
      ),
      width: furniture.width,
      height: furniture.height,
      child: Actor(
        child: furniture.item != null
            ? Image.asset(
                'assets/furniture/${furniture.item}.png',
                alignment: furniture.orientation == 'right'
                    ? AlignmentDirectional.topEnd
                    : furniture.orientation == 'left'
                        ? AlignmentDirectional.topStart
                        : AlignmentDirectional.center,
                scale: furniture.scale,
          /* == 'rugRed' */
          /*           ? 1 */
          /*           : furniture.item == 'fireplace' */
          /*               ? 2 */
          /*               : furniture.item == 'coffeeTable' */
          /*                   ? 4 */
          /*                   : 3, */
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
