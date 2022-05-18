enum itemType {
  bed,
}

class StoreItem {
  final String name;
  final icon;
  final itemType type;
  final double price;

  const StoreItem({
    required this.name,
    required this.icon,
    required this.type,
    required this.price,
  });
}
