import 'package:flutter/material.dart';
import 'package:projectmercury/pages/homePage/floor_plan.dart';
import 'package:projectmercury/pages/homePage/room_data.dart';
import 'package:projectmercury/pages/storePage/store_page.dart';
import 'package:projectmercury/resources/locator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Rooms _rooms = locator.get<Rooms>();
    final _currentRoom = _rooms.rooms[1];
    const _homeLayout = FloorPlan();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: InteractiveViewer(
          boundaryMargin: const EdgeInsets.all(30.0),
          minScale: 1.0,
          maxScale: 3.0,
          child: Center(
            child: FittedBox(
              child: _currentRoom,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.storefront, size: 42),
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              context: context,
              builder: (context) {
                return StorePage(room: _currentRoom);
              },
            );
          },
        ));
  }
}
