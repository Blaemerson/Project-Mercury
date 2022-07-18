// Holds data relating to furniture
class Furniture {
  final String name;
  final String direction;
  final double xPosition;
  final double yPosition;
  final double width;
  final double height;

  // Note: direction refers to whichever direction the "back" side of the furniture is facing
  const Furniture({
    required this.name,
    this.direction = "",
    required this.xPosition,
    required this.yPosition,
    required this.width,
    required this.height,
  });
}
