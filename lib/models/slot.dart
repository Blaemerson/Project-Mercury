import 'package:flutter/material.dart';

class Slot {
  final int id;
  final int? prereq;
  final Size size;
  final Offset position;
  final double zPosition;
  final List<String> acceptables;
  final String? visual;
  final double overchargeRate;
  final bool delay;
  final bool doubleCharge;
  String? item;

  Slot({
    required this.id,
    required this.size,
    required this.acceptables,
    required this.position,
    this.prereq,
    this.item,
    this.overchargeRate = 0,
    this.delay = false,
    this.doubleCharge = false,
    this.zPosition = 0,
    this.visual,
  });
  set(String? item) => this.item = item;
}
// Holds data relating to furniture slot
