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
  double _x = 0;
  double _y = 0;
  double _fov = 15;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          // Consumer<List<PurchasedItem>>(
          //   builder: (_, items, __) {
          //     return SizedBox(
          //       height: 80,
          //       child: ListView.builder(
          //         itemCount: items.length,
          //         scrollDirection: Axis.horizontal,
          //         itemBuilder: ((context, index) {
          //           /* Create a new draggable element for each item */
          //           return LongPressDraggable(
          //             delay: const Duration(milliseconds: 250),
          //             data: items[index],
          //             /* TODO: change representation of purchased furniture from their icon */
          //             child: Icon(
          //               IconData(items[index].icon,
          //                   fontFamily: 'MaterialIcons'),
          //               size: 50,
          //             ),
          //             feedback: Icon(
          //               IconData(items[index].icon,
          //                   fontFamily: 'MaterialIcons'),
          //               size: 50,
          //             ),
          //             childWhenDragging: Container(),
          //           );
          //         }),
          //       ),
          //     );
          //   },
          // ),
          Row(
            children: [
              const Text('Fov'),
              Expanded(
                child: Slider(
                    value: _fov,
                    min: 0,
                    max: 30,
                    onChanged: (fov) => setState(() {
                          _fov = fov;
                        })),
              ),
              Text(_x.toStringAsPrecision(3)),
            ],
          ),
          Row(
            children: [
              const Text('X'),
              Expanded(
                child: Slider(
                    value: _x,
                    min: -90,
                    max: 90,
                    onChanged: (x) => setState(() {
                          _x = x;
                        })),
              ),
              Text(_x.toStringAsPrecision(3)),
            ],
          ),
          Row(
            children: [
              const Text('Y'),
              Expanded(
                child: Slider(
                    value: _y,
                    min: 0,
                    max: 360,
                    onChanged: (y) => setState(() {
                          _y = y;
                        })),
              ),
              Text(_y.toStringAsPrecision(3)),
            ],
          ),
          const Spacer(),
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
            child: Center(
              child: InteriorCube(
                width: 300,
                height: 200,
                depth: 200,
                rotateY: _y * math.pi / 180,
                rotateX: _x * math.pi / 180,
                fov: _fov * math.pi / 180,
              ),
            ),
          ),
          const Spacer(),
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
