import 'package:flutter/material.dart';
import 'package:projectmercury/models/furniture.dart';
import 'package:projectmercury/models/scam.dart';
import 'package:projectmercury/resources/event_controller.dart';
import 'package:projectmercury/resources/locator.dart';

class Slot {
  final int id;
  final int? prereq;
  final double height;
  final Offset position;
  final double zPosition;
  final List<Furniture> acceptables;
  final String? visual;
  final Scam scam;
  bool owned;
  String? item;

  Slot({
    required this.id,
    required this.height,
    required this.acceptables,
    required this.position,
    /* this.owned = false, */
    this.owned = false,
    this.prereq,
    this.item,
    this.zPosition = 0,
    this.scam = const Scam(),
    this.visual,
  });
  set(String? item) {
    if (item == null) {
      owned = false;
    }
    this.item = item;
  }
  get(String itemName) =>
      acceptables.where((element) => element.name == itemName);
}
// Holds data relating to furniture slot
