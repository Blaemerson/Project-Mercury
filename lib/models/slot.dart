import 'package:flutter/material.dart';
import 'package:projectmercury/models/furniture.dart';

class Slot {
  final int id;
  final int? prereq;
  final double height;
  final Offset position;
  final double zPosition;
  final List<Furniture> acceptables;
  final String? visual;
  final double overchargeRate;
  final bool delay;
  final bool doubleCharge;
  String? item;

  Slot({
    required this.id,
    required this.height,
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
  get(String itemName) => acceptables.where((element) => element.name == itemName);
}
// Holds data relating to furniture slot
