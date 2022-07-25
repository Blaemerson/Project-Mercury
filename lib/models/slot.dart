import 'package:flutter/material.dart';
import 'package:projectmercury/models/furniture.dart';
import 'package:projectmercury/models/scam.dart';

class Slot {
  final int id;
  final int? prereq;
  final double height;
  final Offset position;
  final double zPosition;
  final List<Furniture> acceptables;
  final String? visual;
  final Scam scam;
  String? item;

  Slot({
    required this.id,
    required this.height,
    required this.acceptables,
    required this.position,
    this.prereq,
    this.item,
    this.zPosition = 0,
    this.scam = const Scam(),
    this.visual,
  });
  set(String? item) => this.item = item;
  get(String itemName) =>
      acceptables.where((element) => element.name == itemName);
}
// Holds data relating to furniture slot
