import 'package:flutter/material.dart';
import 'package:projectmercury/models/furniture_slot.dart';

import 'package:projectmercury/widgets/furniture_card.dart';
import 'package:projectmercury/widgets/room.dart';

class BedRoom extends StatefulWidget {
  const BedRoom({Key? key}) : super(key: key);

  @override
  State<BedRoom> createState() => _BedRoomState();
}

// TODO: Layout undecided
class _BedRoomState extends State<BedRoom> {
  @override
  Widget build(BuildContext context) {
    return Room(
      name: 'bedroom',
      width: 300,
      depth: 300,
      floorTexture: "assets/light_wood.jpg",
      wallTexture: "assets/grey_wall.jpg",
      items: [
        FurnitureSlot(
          width: 100,
          height: 100,
          positionX: 50,
          positionY: 120,
          type: 'table',
          variant: '1',
        )
      ],
    );
  }
}
