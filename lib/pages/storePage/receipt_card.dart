import 'package:flutter/material.dart';
import 'package:projectmercury/models/store_item.dart';
import 'package:projectmercury/utils/utils.dart';

class ReceiptCard extends StatelessWidget {
  final PurchasedItem purchasedItem;
  const ReceiptCard({required this.purchasedItem, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/furniture/${purchasedItem.item}.png',
                width: 75,
                height: 75,
              ),
              Flexible(
                child: Column(
                  children: [
                    Text(purchasedItem.name,
                        style: const TextStyle(fontSize: 25)),
                    Text(purchasedItem.timeBought.toString()),
                  ],
                ),
              ),
              Text(formatCurrency.format(purchasedItem.price),
                  style: const TextStyle(fontSize: 28)),
            ],
          ),
        ],
      ),
    );
  }
}
