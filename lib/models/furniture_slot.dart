/// Creates a slot for furniture to be placed in a room.
class FurnitureSlot {
  final double width;
  final double height;
  final double distanceFromLeft;
  final double distanceFromRight;
  final String type;
  final bool interactable;
  String? variant;
  FurnitureSlot({
    required this.width,
    required this.height,
    required this.distanceFromLeft,
    required this.distanceFromRight,
    this.interactable = false,
    required this.type,
    this.variant,
  }) : assert(distanceFromLeft >= 0 &&
            distanceFromLeft <= 1 &&
            distanceFromRight >= 0 &&
            distanceFromLeft <= 1);

  set(String? variant) {
    this.variant = variant;
  }
}
