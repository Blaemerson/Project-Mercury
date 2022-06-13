import 'package:flutter/material.dart';
import 'package:projectmercury/widgets/cube.dart';
import 'dart:math' as math;

import 'package:projectmercury/widgets/furniture.dart';

class BedRoom extends StatefulWidget {
  const BedRoom({Key? key}) : super(key: key);

  @override
  State<BedRoom> createState() => _BedRoomState();
}

// TODO: Layout undecided
class _BedRoomState extends State<BedRoom> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        Cube(
          width: 400,
          height: 170,
          depth: 400,
          rotateY: 45 * math.pi / 180,
          rotateX: 45 * math.pi / 180,
          fov: 0 * math.pi / 180,
          floorTexture: AssetImage('assets/light_wood.jpg'),
          wallTexture: AssetImage('assets/grey_wall.jpg'),
        ),
        Positioned(
          top: 130,
          child: SizedBox(
            height: 100,
            width: 100,
            child: Furniture(type: "table", variant: 0),
          ),
        ),
      ],
    );
  }
}
