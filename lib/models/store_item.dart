import 'package:cloud_firestore/cloud_firestore.dart';

class StoreItem {
  final String name;
  final num price;
  final String item;
  final Seller seller;
  const StoreItem({
    this.name = '',
    this.price = 0,
    this.item = '',
    this.seller = Seller.unknown,
  });

  Map<String, dynamic> toJson() {
    return ({
      'name': name,
      'price': price,
      'item': item,
      'seller': seller.name,
    });
  }

  static StoreItem fromSnap(Map<String, dynamic> snap) {
    return StoreItem(
      name: snap['name'],
      price: snap['price'],
      item: snap['item'],
      seller: Seller.values.byName(snap['seller']),
    );
  }
}

class PurchasedItem extends StoreItem {
  String? room;
  DateTime? timeBought;
  final bool delivered;
  PurchasedItem({
    name = '',
    price = 0,
    item = '',
    seller = Seller.unknown,
    this.room = '',
    this.timeBought,
    this.delivered = true,
  }) : super(
          name: name,
          price: price,
          item: item,
          seller: seller,
        );

  @override
  Map<String, dynamic> toJson() {
    return ({
      'name': name,
      'price': price,
      'item': item,
      'seller': seller.name,
      'room': room,
      'timeBought': timeBought,
      'delivered': delivered,
    });
  }

  static PurchasedItem fromSnap(Map<String, dynamic> snap) {
    return PurchasedItem(
      name: snap['name'],
      price: snap['price'],
      item: snap['item'],
      seller: Seller.values.byName(snap['seller']),
      room: snap['room'],
      timeBought: snap['timeBought'] != null
          ? (snap['timeBought'] as Timestamp).toDate()
          : null,
      delivered: snap['delivered'] ?? true,
    );
  }
}

enum Seller {
  unknown,
  furnitureDunRyte,
  fineFurnitureImports,
  maggiesFurnitureDepot,
  theFurnitureSpot,
  gustavesDesigns,
  furnitureYourWay,
  matildaMaes,
  futureFurniture,
  meublesdeMoreau,
  secondhandFurniture,
  marcelasAntiques,
  theMusicCenter,
  topNotchContractors,
  amirsEclectics,
  homePatioAndLawn,
  furnitureClassics,
  modernElectronicsAndMore,
  donsPawnshop,
  phillipesFurniture,
  furnitureNow,
}

extension SellerExtension on Seller {
  String get real {
    switch (this) {
      case Seller.amirsEclectics:
        return "Amir's Electrics";
      case Seller.donsPawnshop:
        return "Don's Pawn Shop";
      case Seller.fineFurnitureImports:
        return 'Fine Furniture Imports';
      case Seller.furnitureYourWay:
        return 'Furniture Your Way';
      case Seller.furnitureClassics:
        return 'Furniture Classics';
      case Seller.furnitureDunRyte:
        return 'Furniture Dun Ryte';
      case Seller.furnitureNow:
        return 'Furniture Now';
      case Seller.futureFurniture:
        return 'Future Furniture';
      case Seller.gustavesDesigns:
        return "Gustave's Designs";
      case Seller.homePatioAndLawn:
        return 'Home Patio and Lawn';
      case Seller.maggiesFurnitureDepot:
        return "Maggie's Furniture Depot";
      case Seller.marcelasAntiques:
        return "Marcela's Antiques";
      case Seller.matildaMaes:
        return "Matilda Maes";
      case Seller.meublesdeMoreau:
        return 'Meubles de Moreau';
      case Seller.modernElectronicsAndMore:
        return 'Modern Electronics and More';
      case Seller.phillipesFurniture:
        return "Phillipe's Furniture";
      case Seller.secondhandFurniture:
        return 'Secondhand Furniture';
      case Seller.theFurnitureSpot:
        return 'The Furniture Spot';
      case Seller.theMusicCenter:
        return 'The Music Center';
      case Seller.topNotchContractors:
        return 'Top Notch Contractors';
      default:
        return 'Unknown Store';
    }
  }

  String get fake {
    switch (this) {
      case Seller.furnitureDunRyte:
        return 'Furniture Dun Now';
      case Seller.marcelasAntiques:
        return "Marabelle's Antiques";
      case Seller.modernElectronicsAndMore:
        return "Modern Electronics Now";
      default:
        return 'Suspicious Store';
    }
  }
}
