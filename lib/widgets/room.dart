import 'package:flutter/material.dart';
import 'package:projectmercury/widgets/cube.dart';
import 'package:projectmercury/widgets/furniture.dart';
import 'dart:math' as math;

class Room extends StatelessWidget {
  final double width;
  final double depth;
  final String floorTexture;
  final String wallTexture;
  final List<Furniture> items;
  const Room({
    Key? key,
    this.floorTexture = 'assets/wood_floor.jpg',
    this.wallTexture = 'assets/floral_wall.jpg',
    required this.width,
    required this.depth,
    required this.items,
  }) : super(key: key);

// TODO: load furnitures from firebase and place in correct location
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Cube(
          rotateY: 45 * math.pi / 180,
          // 35.264 <- true isometric view angle
          // 30 <- most commonly used isometric view angle
          rotateX: 35.264 * math.pi / 180,
          width: width,
          height: 180,
          depth: depth,
          floorTexture: AssetImage(floorTexture),
          wallTexture: AssetImage(wallTexture),
        ),
        for (Furniture item in items) ...[
          item,
        ]
      ],
    );
  }
}
