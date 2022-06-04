import 'package:cloud_firestore/cloud_firestore.dart';

class StoreItem {
  final String name;
  final int icon;
  final String type;
  final num price;

  StoreItem({
    this.name = '',
    this.icon = 0,
    this.type = '',
    this.price = 0,
  });

  Map<String, dynamic> toJson() {
    return ({
      'name': name,
      'icon': icon,
      'type': type,
      'price': price,
    });
  }

  static StoreItem fromSnap(Map<String, dynamic> snap) {
    return StoreItem(
      name: snap['name'],
      icon: snap['icon'],
      type: snap['type'],
      price: snap['price'],
    );
  }
}

class PurchasedItem extends StoreItem {
  DateTime? timeBought;
  PurchasedItem({
    name = '',
    icon = 0,
    type = '',
    price = 0,
    this.timeBought,
  }) : super(
          name: name,
          icon: icon,
          type: type,
          price: price,
        );

  @override
  Map<String, dynamic> toJson() {
    return ({
      'name': name,
      'icon': icon,
      'type': type,
      'price': price,
      'timeBought': timeBought,
    });
  }

  static PurchasedItem fromSnap(Map<String, dynamic> snap) {
    return PurchasedItem(
      name: snap['name'],
      icon: snap['icon'],
      type: snap['type'],
      price: snap['price'],
      timeBought: snap['timeBought'] != null
          ? (snap['timeBought'] as Timestamp).toDate()
          : null,
    );
  }
}
