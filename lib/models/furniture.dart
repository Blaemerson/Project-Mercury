import 'package:flutter/material.dart';

class Furniture {
  final String name;
  final Size? size;
  final Offset? position;
  final double? zPosition;
  final String? direction;
  final int? slotID;

  const Furniture({
    required this.name,
    this.position,
    this.size,
    this.zPosition = 0,
    this.direction,
    this.slotID,
  });
}
// Holds data relating to furniture
