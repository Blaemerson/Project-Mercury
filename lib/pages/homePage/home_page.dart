import 'package:flutter/material.dart';
import 'package:projectmercury/pages/storePage/store_page.dart';
import 'package:projectmercury/widgets/room.dart';
import 'package:projectmercury/widgets/rooms/bedroom.dart';

import 'package:projectmercury/widgets/rooms/livingroom.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _rooms = const [
    BedRoom(),
    LivingRoom(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: InteractiveViewer(
        boundaryMargin: const EdgeInsets.all(30.0),
        minScale: 1.0,
        maxScale: 2.0,
        child: Center(
          child: FittedBox(
            child: _rooms[1],
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
