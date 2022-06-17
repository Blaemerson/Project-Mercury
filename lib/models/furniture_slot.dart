class FurnitureSlot {
  final double width;
  final double height;
  final double positionX;
  final double positionY;
  final String type;
  String? variant;
  FurnitureSlot({
    required this.width,
    required this.height,
    required this.positionX,
    required this.positionY,
    required this.type,
    this.variant,
  });

  set(String? variant) {
    this.variant = variant;
  }
}
