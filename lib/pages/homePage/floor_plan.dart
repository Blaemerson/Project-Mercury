import 'package:flutter/material.dart';
import 'package:projectmercury/pages/homePage/room_data.dart';
import 'package:projectmercury/resources/locator.dart';

class FloorPlan extends StatelessWidget {
  const FloorPlan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Rooms _rooms = locator.get<Rooms>();
    // TODO: Finalize home layout
    // Subject to change
    return SizedBox(
      width: 1150,
      height: 800,
      child: Stack(
        children: [
          Positioned(left: 323, child: _rooms.rooms[1]), // Bathroom
          Positioned(left: 463, top: 81, child: _rooms.rooms[0]), // Bedroom
          Positioned(left: 638, top: 180, child: _rooms.rooms[6]), // Washroom
          Positioned(left: 744, top: 244, child: _rooms.rooms[7]), // Garage
          Positioned(left: 178, top: 110, child: _rooms.rooms[5]), // Hall
          Positioned(left: 567, top: 346, child: _rooms.rooms[3]), // Livingroom
          Positioned(left: 0, top: 223, child: _rooms.rooms[2]), // Kitchen
          Positioned(left: 249, top: 360, child: _rooms.rooms[4]), // Diningroom
        ],
      ),
    );
  }
}
