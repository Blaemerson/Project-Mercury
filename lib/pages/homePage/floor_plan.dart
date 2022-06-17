import 'package:flutter/material.dart';
import 'package:projectmercury/pages/homePage/room_data.dart';
import 'package:projectmercury/resources/locator.dart';

class FloorPlan extends StatelessWidget {
  const FloorPlan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Rooms _rooms = locator.get<Rooms>();
    // TODO: Finalize home layout
    return SizedBox(
      width: 800,
      height: 800,
      child: Stack(
        children: [
          Positioned(child: _rooms.rooms[0]),
          Positioned(left: 210, top: 120, child: _rooms.rooms[1]),
          Positioned(left: 388, top: 222, child: _rooms.rooms[3]),
          Positioned(left: 35, top: 242, child: _rooms.rooms[2]),
        ],
      ),
    );
  }
}
