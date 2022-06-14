import 'package:flutter/material.dart';

import 'package:projectmercury/widgets/furniture.dart';
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
    return const Room(
      width: 300,
      depth: 300,
      floorTexture: "assets/light_wood.jpg",
      wallTexture: "assets/grey_wall.jpg",
      items: [
        Furniture(
          width: 100,
          height: 100,
          positionX: 50,
          positionY: 120,
          type: 'table',
          variant: '',
        )
      ],
    );
  }
}
