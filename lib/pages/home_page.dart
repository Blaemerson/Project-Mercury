import 'package:flutter/material.dart';
import 'package:projectmercury/pages/store_page.dart';
import 'package:projectmercury/utils/utils.dart';
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
          return Center(
            child: Stack(
              children: [
                /* Position each tile correctly */
                /* TODO: Make this clearer, and remove the hardcoded values */
                for (double i = 0, j = 0;
                    i < 16;
                    i++, (i % 4 == 0) ? j += 42.426 / 2 : j += 0)
                  Tile(
                      tileSize: 30,
                      offsetX: i * 42.426 / 2 - (j * 3),
                      offsetY: i * 42.426 / 2 - (j * 5)),
                      Column(children: [
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
                      size: 70,
                    ),
                    childWhenDragging: Container(),
                  ),

                      ],)
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

// TODO: See if this must be stateful
class Tile extends StatefulWidget {
  const Tile(
      {Key? key,
      required this.tileSize,
      required this.offsetX,
      required this.offsetY})
      : super(key: key);

  final double tileSize;
  final double offsetX;
  final double offsetY;

  @override
  State<StatefulWidget> createState() => _TileState();
}

class _TileState extends State<Tile> {
  bool _occupied = false;
  String _occupyingFurniture = '';
  int _tileRotation = 0;
  PurchasedItem _furniture = PurchasedItem();

  @override
  Widget build(BuildContext context) {
    Color _color = Colors.lightBlueAccent;
    return Transform.translate(
      offset: Offset(widget.offsetX, widget.offsetY),
      child: Transform.rotate(
        angle: 3.1415 / 4,
        child: DragTarget(
          builder: ((context, candidateData, rejectedData) {
            return Container(
              height: widget.tileSize,
              width: widget.tileSize,
              /* color: Colors.grey, */
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
                color: _color,
              ),
              child:
                  Icon(IconData(_furniture.icon, fontFamily: 'MaterialIcons')),
            );
          }),
          onLeave: (PurchasedItem? data) {
            _color = Colors.lightBlueAccent;
          },
          onWillAccept: (PurchasedItem? data) {
            /* TODO: Only accept furniture if there is space for it on the floor. */
            _color = Colors.red;
            return true;
          },
          onAccept: (PurchasedItem data) {
            setState(() {
              if (_occupied == false) {
                showSnackBar(
                    'Added ${data.name.toLowerCase()} to home.', context);

                _furniture = data;
                _occupied = true;
                _occupyingFurniture = data.name;
              } else {
                showSnackBar('Failed', context);
                _furniture = PurchasedItem();
                _occupied = false;
                _occupyingFurniture = '';
              }
            });
          },
        ),
      ),
    );
  }
}
