import 'package:flutter/material.dart';
import 'package:projectmercury/pages/store_page.dart';
import 'package:projectmercury/widgets/home_floor_tile.dart';
import 'package:projectmercury/models/tile.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import 'package:projectmercury/models/store_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          Consumer<List<PurchasedItem>>(
            builder: (_, items, __) {
              return SizedBox(
                height: 100,
                child: ListView.builder(
                  itemCount: items.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: ((context, index) {
                    /* Create a new draggable element for each item */
                    return LongPressDraggable(
                      delay: const Duration(milliseconds: 250),
                      feedbackOffset: Offset(0, 1000),
                      data: items[index],
                      /* TODO: change representation of purchased furniture from their icon */
                      child: Icon(
                        IconData(items[index].icon,
                            fontFamily: 'MaterialIcons'),
                        size: 50,
                      ),
                      feedback: Icon(
                        IconData(items[index].icon,
                            fontFamily: 'MaterialIcons'),
                        size: 50,
                      ),
                      childWhenDragging: Container(),
                    );
                  }),
                ),
              );
            },
          ),
          Stack(
            children: [
              Consumer<List<Tile>>(
                builder: (_, tiles, __) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(45.0),
                      child: Transform(
                        alignment: AlignmentDirectional.center,
                        transform: Matrix4.rotationX(math.pi / 3),
                        child: Transform(
                          transform: Matrix4.rotationZ(math.pi / 4),
                          alignment: AlignmentDirectional.center,
                          child: GridView.count(
                            crossAxisCount: 5,
                            primary: false,
                            shrinkWrap: true,
                            children: [
                              for (Tile tile in tiles)
                                HomeFloorTile(tile: tile),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
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
