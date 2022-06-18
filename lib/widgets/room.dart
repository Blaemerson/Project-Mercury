import 'package:flutter/material.dart';
import 'package:projectmercury/models/store_item.dart';
import 'package:projectmercury/widgets/cube.dart';
import 'package:projectmercury/models/furniture_slot.dart';
import 'dart:math' as math;

import 'package:projectmercury/widgets/furniture_card.dart';
import 'package:provider/provider.dart';

class Room extends StatefulWidget {
  final String name;
  final double width;
  final double depth;
  final double height;
  final String floorTexture;
  final String wallTexture;
  final List<FurnitureSlot> items;
  const Room({
    Key? key,
    required this.name,
    this.floorTexture = 'assets/wood_floor.jpg',
    this.wallTexture = 'assets/floral_wall.jpg',
    required this.width,
    this.height = 180,
    required this.depth,
    required this.items,
  }) : super(key: key);

  update(String type, String variant) {
    items.where((item) => item.type == type).first.set(variant);
  }

  @override
  State<Room> createState() => _RoomState();
}

class _RoomState extends State<Room> {
  String get name {
    return widget.name;
  }

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
            width: (widget.width + widget.depth) * math.cos(_rotationY),
            // The length of the diagonal from front to back, plus the height of the box, accounting for projection
            height: math.sqrt(
                        math.pow(widget.width, 2) + math.pow(widget.depth, 2)) *
                    math.cos(_rotationY) *
                    math.cos(_rotationX) +
                (widget.height) * math.cos(_rotationX),
            child: Cube(
              rotateY: _rotationY,
              rotateX: _rotationX,
              width: widget.width,
              height: widget.height,
              depth: widget.depth,
              floorTexture: AssetImage(widget.floorTexture),
              wallTexture: AssetImage(widget.wallTexture),
            ),
          ),
        ),
        for (FurnitureSlot item in widget.items) ...[
          // TODO: allow more that one item per type
          Consumer<List<PurchasedItem>>(builder: (_, userItems, __) {
            List<PurchasedItem> roomItem = userItems
                    .where((element) =>
                        element.room == widget.name &&
                        element.type == item.type)
                    .isNotEmpty
                ? userItems
                    .where((element) =>
                        element.room == widget.name &&
                        element.type == item.type)
                    .toList()
                : [];
            roomItem.isNotEmpty ? item.set(roomItem.first.variant) : null;

            return FurnitureCard(furniture: item);
          }),
        ]
      ],
    );
  }
}
