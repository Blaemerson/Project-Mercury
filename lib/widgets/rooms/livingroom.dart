import 'package:flutter/material.dart';

import 'package:projectmercury/widgets/furniture.dart';
import 'package:projectmercury/widgets/room.dart';

class LivingRoom extends StatefulWidget {
  const LivingRoom({Key? key}) : super(key: key);

  @override
  State<LivingRoom> createState() => _LivingRoomState();
}

// TODO: Layout undecided
class _LivingRoomState extends State<LivingRoom> {
  @override
  Widget build(BuildContext context) {
    return const Room(
      width: 250,
      depth: 300,
      items: [
        Furniture(
          width: 100,
          height: 100,
          positionX: 170,
          positionY: 20,
          type: 'table',
          variant: '',
        ),
        Furniture(
          width: 150,
          height: 150,
          positionX: 0,
          positionY: 95,
          type: 'fireplace',
          variant: '',
        ),
        Furniture(
          width: 100,
          height: 100,
          positionX: 140,
          positionY: 170,
          type: 'chair',
          variant: '',
        ),
      ],
    );
  }
}
