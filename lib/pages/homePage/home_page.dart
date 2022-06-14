import 'package:flutter/material.dart';
import 'package:projectmercury/pages/storePage/store_page.dart';

import 'package:projectmercury/widgets/living_room.dart';

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
      body: InteractiveViewer(
        boundaryMargin: const EdgeInsets.all(30.0),
        /* scrollDirection: Axis.horizontal, */
        minScale: 1.0,
        maxScale: 2.0,
        child: Center(
          child: FittedBox(
            child: Container(
              color: Colors.blue,
              width: 300,
              height: 300,
              child: Room(width: 200, depth: 200),
            ),
          ),
        ),
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
