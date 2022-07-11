/// Creates a slot for furniture to be placed in a room.
class FurnitureSlot {
  final double width;
  final double height;
  final double distanceFromLeft;
  final double distanceFromRight;
  final String orientation;
  final num overchargeRate;
  final List<String> possibleItems;
  final double scale;
  String? item;
  FurnitureSlot({
    required this.width,
    required this.height,
    required this.distanceFromLeft,
    required this.distanceFromRight,
    this.overchargeRate = 0,
    this.possibleItems = const <String>[],
    this.orientation = '',
    this.scale = 3,
    this.item,
  }) : assert(distanceFromLeft >= 0 &&
            distanceFromLeft <= 1 &&
            distanceFromRight >= 0 &&
            distanceFromLeft <= 1);

  set(String? item) {
    this.item = item;
  }
}
