import 'package:cloud_firestore/cloud_firestore.dart';

class StoreItem {
  final String name;
  final num price;
  final String item;

  const StoreItem({
    this.name = '',
    this.price = 0,
    this.item = '',
  });

  Map<String, dynamic> toJson() {
    return ({
      'name': name,
      'price': price,
      'item': item,
    });
  }

  static StoreItem fromSnap(Map<String, dynamic> snap) {
    return StoreItem(
      name: snap['name'],
      price: snap['price'],
      item: snap['item'],
    );
  }
}

class PurchasedItem extends StoreItem {
  String? room;
  DateTime? timeBought;
  PurchasedItem({
    name = '',
    price = 0,
    item = '',
    this.room = '',
    this.timeBought,
  }) : super(
          name: name,
          price: price,
          item: item,
        );

  @override
  Map<String, dynamic> toJson() {
    return ({
      'name': name,
      'price': price,
      'item': item,
      'room': room,
      'timeBought': timeBought,
    });
  }

  static PurchasedItem fromSnap(Map<String, dynamic> snap) {
    return PurchasedItem(
      name: snap['name'],
      price: snap['price'],
      item: snap['item'],
      room: snap['room'],
      timeBought: snap['timeBought'] != null
          ? (snap['timeBought'] as Timestamp).toDate()
          : null,
    );
  }
}
