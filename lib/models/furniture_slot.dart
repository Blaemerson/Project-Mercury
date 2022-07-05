/// Creates a slot for furniture to be placed in a room.
class FurnitureSlot {
  final double width;
  final double height;
  final double distanceFromLeft;
  final double distanceFromRight;
  final List<String> possibleItems;
  String? item;
  FurnitureSlot({
    required this.width,
    required this.height,
    required this.distanceFromLeft,
    required this.distanceFromRight,
    required this.possibleItems,
    this.item,
  }) : assert(distanceFromLeft >= 0 &&
            distanceFromLeft <= 1 &&
            distanceFromRight >= 0 &&
            distanceFromLeft <= 1);

  set(String? item) {
    this.item = item;
  }
}
