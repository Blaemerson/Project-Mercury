import 'package:flutter/material.dart';
import 'package:projectmercury/models/store_item.dart';
import 'dart:math' as math;

import 'package:projectmercury/models/tile.dart';

class HomeFloorTile extends StatefulWidget {
  final Tile tile;
  const HomeFloorTile({
    Key? key,
    required this.tile,
  }) : super(key: key);

  @override
  State<HomeFloorTile> createState() => _HomeFloorTileState();
}

class _HomeFloorTileState extends State<HomeFloorTile> {
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
              child: widget.tile.occupied
                  ? LongPressDraggable(
                      delay: const Duration(milliseconds: 250),
                      data: widget.tile.furniture,
                      /* TODO: change representation of purchased furniture from their icon */
                      child: Icon(
                        IconData(widget.tile.furniture!.icon,
                            fontFamily: 'MaterialIcons'),
                        size: 50,
                      ),
                      feedback: Icon(
                        IconData(widget.tile.furniture!.icon,
                            fontFamily: 'MaterialIcons'),
                        size: 50,
                      ),
                      childWhenDragging: Container(),
                      onDragStarted: () {
                        debugPrint('Picked up ${widget.tile.furniture!.name}');
                        widget.tile.occupied = false;
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
        if (widget.tile.occupied == false) {
          widget.tile.furniture = data;
          widget.tile.occupied = true;
          _color = const Color.fromARGB(100, 200, 200, 200);
          debugPrint('Added ${data.name} to tile.');
          /* showSnackBar('Added ${data.name.toLowerCase()} to home. (Occupied: $_occupied)', context); */
        } else {
          debugPrint(
              'Furniture not added to tile; tile is occupied by ${widget.tile.furniture!.name}');
        }
      },
    );
  }
}
