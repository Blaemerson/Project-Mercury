import 'package:cloud_firestore/cloud_firestore.dart';

class StoreItem {
  final String name;
  final num price;
  final String item;
  /* final String variant; */

  const StoreItem({
    this.name = '',
    this.price = 0,
    this.item = '',
    /* this.variant = '', */
  });

  Map<String, dynamic> toJson() {
    return ({
      'name': name,
      'price': price,
      'item': item,
      /* 'variant': variant, */
    });
  }

  static StoreItem fromSnap(Map<String, dynamic> snap) {
    return StoreItem(
      name: snap['name'],
      price: snap['price'],
      item: snap['item'],
      /* variant: snap['variant'], */
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
    /* variant = '', */
    this.room = '',
    this.timeBought,
  }) : super(
          name: name,
          price: price,
          item: item,
          /* variant: variant, */
        );

  @override
  Map<String, dynamic> toJson() {
    return ({
      'name': name,
      'price': price,
      'item': item,
      /* 'variant': variant, */
      'room': room,
      'timeBought': timeBought,
    });
  }

  static PurchasedItem fromSnap(Map<String, dynamic> snap) {
    return PurchasedItem(
      name: snap['name'],
      price: snap['price'],
      item: snap['item'],
      /* variant: snap['variant'], */
      room: snap['room'],
      timeBought: snap['timeBought'] != null
          ? (snap['timeBought'] as Timestamp).toDate()
          : null,
    );
  }
}
