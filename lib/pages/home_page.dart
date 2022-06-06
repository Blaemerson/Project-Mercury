import 'package:flutter/material.dart';
import 'package:projectmercury/pages/store_page.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import '../models/store_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Consumer<List<Tile>>(builder: (_, tiles, __) {
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
                        for (Tile tile in tiles) tile,
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
          Consumer<List<PurchasedItem>>(builder: (_, items, __) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (PurchasedItem item in items)
                  /* Create a new draggable element for each item */
                  Draggable(
                    data: item,
                    /* TODO: change representation of purchased furniture from their icon */
                    child: Icon(
                      IconData(item.icon, fontFamily: 'MaterialIcons'),
                      size: 50,
                    ),
                    feedback: Icon(
                      IconData(item.icon, fontFamily: 'MaterialIcons'),
                      size: 50,
                    ),
                    childWhenDragging: Container(),
                  ),
              ],
            );
          })
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

class Tile extends StatelessWidget {
  Tile({Key? key}) : super(key: key);

  bool _occupied = false;
  PurchasedItem _furniture = PurchasedItem();

  @override
  Widget build(BuildContext context) {
    Color _color = const Color.fromARGB(100, 200, 200, 200);
    return DragTarget(
      builder: ((context, candidateData, rejectedData) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            color: _color,
          ),
          child: Transform(
            alignment: AlignmentDirectional.center,
            transform: Matrix4.rotationZ(-math.pi / 4),
            child: Transform(
              alignment: AlignmentDirectional.center,
              transform: Matrix4.rotationY(math.pi / 3),
              child: _occupied
                  ? Draggable(
                      data: _furniture,
                      /* TODO: change representation of purchased furniture from their icon */
                      child: Icon(
                        IconData(_furniture.icon, fontFamily: 'MaterialIcons'),
                        size: 50,
                      ),
                      feedback: Icon(
                        IconData(_furniture.icon, fontFamily: 'MaterialIcons'),
                        size: 50,
                      ),
                      childWhenDragging: Container(),
                      onDragStarted: () {
                        print('Picked up ${_furniture.name}');
                        _occupied = false;
                      },
                    )
                  : Container(),
            ),
          ),
        );
      }),
      onLeave: (PurchasedItem? data) {
        _color = const Color.fromARGB(100, 200, 200, 200);
      },
      onWillAccept: (PurchasedItem? data) {
        _color = Colors.grey;
        return true;
      },
      onAccept: (PurchasedItem data) {
        if (_occupied == false) {
          _furniture = data;
          _occupied = true;
          _color = const Color.fromARGB(100, 200, 200, 200);
          print('Added ${data.name} to tile.');
          /* showSnackBar('Added ${data.name.toLowerCase()} to home. (Occupied: $_occupied)', context); */
        } else {
          print(
              'Furniture not added to tile; tile is occupied by ${_furniture.name}');
        }
      },
    );
  }
}
