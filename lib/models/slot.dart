import 'package:projectmercury/models/furniture.dart';

// Holds data relating to furniture slot
class Slot {
  final String room;
  final double width;
  final double length;
  final double height;
  final double yPosition;
  final double xPosition;
  final num overchargeRate; // hardcode transaction overcharge
  final bool doubleCharge; // item charged twice (overrides overchargeRate)
  final bool delay;
  String? item;
  final List<Furniture> items;

  Slot({
    required this.room,
    required this.width,
    required this.length,
    required this.height,
    required this.yPosition,
    required this.xPosition,
    this.overchargeRate = 0,
    this.doubleCharge = false,
    this.delay = false,
    required this.items,
  });

  set(String? item) {
    this.item = item;
  }
}
