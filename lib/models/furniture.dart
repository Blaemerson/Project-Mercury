import 'package:flutter/material.dart';

class Furniture {
  final String name;
  final double? height;
  final Offset? position;
  final double? zPosition;
  final String? direction;
  final int? slotID;

  const Furniture({
    required this.name,
    this.position,
    this.height,
    this.zPosition,
    this.direction,
    this.slotID,
  });
}
// Holds data relating to furniture
