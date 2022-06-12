import 'package:flutter/material.dart';
import 'package:projectmercury/pages/store_page.dart';

import 'package:projectmercury/widgets/dining_room.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /* double _x = 20; */
  /* double _y = 0; */
  /* double _fov = 10; */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: const [
          /* Row( */
          /*   children: [ */
          /*     const Text('Fov'), */
          /*     Expanded( */
          /*       child: Slider( */
          /*         value: _fov, */
          /*         min: 0, */
          /*         max: 30, */
          /*         onChanged: (fov) => setState(() { */
          /*           _fov = fov; */
          /*         }), */
          /*       ), */
          /*     ), */
          /*     Text(_fov.toStringAsPrecision(3)), */
          /*   ], */
          /* ), */
          /* Row( */
          /*   children: [ */
          /*     const Text('X'), */
          /*     Expanded( */
          /*       child: Slider( */
          /*         value: _x, */
          /*         min: -90, */
          /*         max: 90, */
          /*         onChanged: (x) => setState(() { */
          /*           _x = x; */
          /*         }), */
          /*       ), */
          /*     ), */
          /*     Text(_x.toStringAsPrecision(3)), */
          /*   ], */
          /* ), */
          /* Row( */
          /*   children: [ */
          /*     const Text('Y'), */
          /*     Expanded( */
          /*       child: Slider( */
          /*         value: _y, */
          /*         min: 0, */
          /*         max: 360, */
          /*         onChanged: (y) => setState(() { */
          /*           _y = y; */
          /*         }), */
          /*       ), */
          /*     ), */
          /*     Text(_y.toStringAsPrecision(3)), */
          /*   ], */
          /* ), */
          /* Spacer(), */
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: LivingRoom(),
          ),
          Spacer(),
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
                return const SizedBox(
                  height: 232,
                  child: StorePage(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
