import 'package:flutter/material.dart';
import 'package:projectmercury/widgets/cube.dart';
import 'package:projectmercury/widgets/furniture.dart';
import 'dart:math' as math;

class Room extends StatelessWidget {
  final double width;
  final double depth;
  final double height;
  final String floorTexture;
  final String wallTexture;
  final List<Furniture> items;
  const Room({
    Key? key,
    this.floorTexture = 'assets/wood_floor.jpg',
    this.wallTexture = 'assets/floral_wall.jpg',
    required this.width,
    this.height = 180,
    required this.depth,
    required this.items,
  }) : super(key: key);

// TODO: load furnitures from firebase and place in correct location
  @override
  Widget build(BuildContext context) {
    double _rotationY = 45 * math.pi / 180;
    // 35.264 <- true isometric view angle
    // 30 <- most commonly used isometric view angle
    double _rotationX = 35.264 * math.pi / 180;

    bool _debugBox = false; // Show the SizedBox containing the room.
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          color: _debugBox ? Colors.red : Colors.transparent,
          child: SizedBox(
            // Trying to fit the box to exactly the cube's visible width and height.
            // TODO: Make it work for rooms with great differences in width and depth, e.g. hallways.
            // Works at least when length and width are within ~100 of each other.
            width: (width + depth) * math.cos(_rotationY),
            // The length of the diagonal from front to back, plus the height of the box, accounting for projection
            height: math.sqrt(math.pow(width, 2) + math.pow(depth, 2)) *
                    math.cos(_rotationY) *
                    math.cos(_rotationX) +
                (height) * math.cos(_rotationX),
            child: Cube(
              rotateY: _rotationY,
              rotateX: _rotationX,
              width: width,
              height: height,
              depth: depth,
              floorTexture: AssetImage(floorTexture),
              wallTexture: AssetImage(wallTexture),
            ),
          ),
        ),
        for (Furniture item in items) ...[
          item.build(context),
        ]
      ],
    );
  }
}
