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
          return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Wrap(children: [
                  for (PurchasedItem item in items)
                    /* Create a new draggable element for each item */
                    Draggable(
                      data: item.name,
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
                    const Tile(depth: 50, offsetX: -100, offsetY: -100),
                    const Tile(depth: 50, offsetX: -50, offsetY: -75),
                    const Tile(depth: 50, offsetX: -150, offsetY: -75),
                    const Tile(depth: 50, offsetX: -100, offsetY: -50),
                ]),
              ]);
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

class Tile extends StatefulWidget {
  const Tile({Key? key, this.child, required this.depth, required this.offsetX, required this.offsetY}) : super(key: key);

  final Widget? child;
  final double depth;
  final double offsetX;
  final double offsetY;

  @override
  State<StatefulWidget> createState() => _TileState();
}

class _TileState extends State<Tile> {
  bool _occupied = false;
  String _occupyingFurniture = '';
  int _tileRotation = 0;

  @override
  Widget build(BuildContext context) {
    return DragTarget(
      builder: ((context, candidateData, rejectedData) {
        return CustomPaint(
          painter: IsometricTilePainter(depth: widget.depth, offsetX: widget.offsetX, offsetY: widget.offsetY),
        );
      }),
      onWillAccept: (data) {
        /* TODO: Only accept furniture if there is space for it on the floor. */
        return data == data;
      },
      onAccept: (data) {
        setState(() {
          /* TODO: Move item to the house when dragged there. */
          showSnackBar(
              'Added ${data.toString().toLowerCase()} to home.', context);
          /* _occupyingFurniture = data.toString(); */
        });
      },
    );
  }
}

class IsometricTilePainter extends CustomPainter {
  const IsometricTilePainter({required this.depth, required this.offsetY, required this.offsetX});
  final double depth;
  final double offsetY;
  final double offsetX;

  @override
  void paint(Canvas canvas, Size size) {
    double x = size.width / 2;
    double y = size.height / 2;
    final floor = Path()
      ..moveTo(x - offsetX, y - offsetY)
      ..lineTo(x - offsetX - depth, y - offsetY - depth * 0.5)
      ..lineTo(x - offsetX - depth + depth, (y - offsetY) - (depth * 0.5 + depth * 0.5))
      ..lineTo(x - offsetX + depth, (y - offsetY) - (depth * 0.5))
      ..close();
    final fill = Paint()
      ..color = Color.fromARGB(100, 150, 150, 150)
      ..style = PaintingStyle.fill;
    canvas.translate(size.width / 2, size.height / 2);
    canvas.save();
    canvas.drawPath(floor, fill);
    canvas.restore();
  }

  @override
  bool shouldRepaint(IsometricTilePainter oldDelegate) => false;
}
