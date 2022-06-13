import 'package:flutter/material.dart';
import 'package:projectmercury/widgets/cube.dart';
import 'dart:math' as math;

import 'package:projectmercury/widgets/furniture.dart';

class LivingRoom extends StatefulWidget {
  const LivingRoom({Key? key}) : super(key: key);

  @override
  State<LivingRoom> createState() => _LivingRoomState();
}

// TODO: Layout undecided
class _LivingRoomState extends State<LivingRoom> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        Cube(
          width: 250,
          height: 170,
          depth: 300,
          rotateY: 45 * math.pi / 180,
          rotateX: 45 * math.pi / 180,
          fov: 0 * math.pi / 180,
          isInterior: true,
        ),
        Positioned(
          bottom: 20,
          right: 30,
          child: SizedBox(
            height: 100,
            width: 100,
            child: Furniture(type: "table", variant: 0),
          ),
        ),
        Positioned(
          top: 50,
          child: SizedBox(
            height: 150,
            width: 150,
            child: Furniture(type: "fireplace", variant: 0),
          ),
        ),
        Positioned(
          top: 30,
          left: 120,
          child: SizedBox(
            height: 100,
            width: 75,
            child: Furniture(type: "chair", variant: 0),
          ),
        ),
      ],
    );
  }
}
