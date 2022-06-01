import 'package:flutter/material.dart';
import 'package:projectmercury/pages/store_page.dart';
import 'package:provider/provider.dart';

import '../models/store_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<List<PurchasedItem>>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Consumer<List<PurchasedItem>>(
        builder: (_, items, __) {
          return SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Wrap(
                  children: [
                    for (PurchasedItem item in items)
                      Icon(
                        IconData(item.icon, fontFamily: 'MaterialIcons'),
                        size: 50,
                      )
                  ],
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: SizedBox(
        width: 64,
        height: 64,
        child: FloatingActionButton(
          child: const Icon(Icons.storefront, size: 42),
          onPressed: () {
            showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              context: context,
              builder: (context) {
                return const StorePage();
              },
            );
          },
        ),
      ),
    );
  }
}
