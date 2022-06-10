import 'package:flutter/material.dart';
import 'package:projectmercury/pages/store_page.dart';
import 'package:projectmercury/widgets/interior_cube.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import 'package:projectmercury/models/store_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Offset _offset = Offset.zero;
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
                height: 80,
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
          // TODO: Make two buttons (possibly slider?) for controlling room rotation.
          GestureDetector(
            /* onPanUpdate: (details) { */
            /*   setState(() { */
            /*     if (details.delta.dx > 2.0 || details.delta.dx < -2.0) { */
            /*       if (_offset.dx < -360.0 || _offset.dx > 360.0) { */
            /*         _offset = Offset(0.0, _offset.dy); */
            /*       } */
            /*       if (_offset.dy < -360.0 || _offset.dy > 360.0) { */
            /*         _offset = Offset(_offset.dx, 0.0); */
            /*       } */
            /*       _offset += details.delta; */
            /*       debugPrint("$_offset"); */
            /*     } */
            /*   }); */
            /* }, */
            child: const Center(
              child: InteriorCube(
                width: 200,
                height: 200,
                depth: 200,
                rotateY: 45 * math.pi / 180,
                rotateX: 0.3,
              ),
            ),
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
