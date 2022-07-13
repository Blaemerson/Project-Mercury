import 'package:flutter/material.dart';
import 'package:projectmercury/pages/homePage/isometric.dart';
import 'package:projectmercury/pages/homePage/room.dart';
import 'package:projectmercury/pages/homePage/room_data.dart';
import 'package:projectmercury/resources/locator.dart';

class FloorPlan extends StatelessWidget {
  const FloorPlan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Room> _rooms = locator.get<Rooms>().rooms;
    return SizedBox(
      width: 600,
      height: 705,
      child: IsometricView(
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            /*Washroom*/
            Positioned(
              left: 0,
              bottom: 0,
              child: Actor(
                child: _rooms[5],
              ),
            ),

            /*Kitchen*/
            Positioned(
              left: 0,
              bottom: _rooms[5].length,
              child: Actor(
                child: _rooms[3],
              ),
            ),

            /*Diningroom*/
            Positioned(
              left: 0,
              bottom: _rooms[5].length + _rooms[3].length,
              child: Actor(
                child: _rooms[4],
              ),
            ),

            /*Bathroom*/
            Positioned(
              left: _rooms[5].width,
              bottom: 0,
              child: Actor(
                child: _rooms[2],
              ),
            ),
            /*Bedroom*/
            Positioned(
              left: _rooms[3].width,
              bottom: _rooms[2].length,
              child: Actor(
                child: _rooms[0],
              ),
            ),
            /*Livingroom*/
            Positioned(
              left: _rooms[4].width,
              bottom: _rooms[0].length + _rooms[2].length,
              child: Actor(
                child: _rooms[1],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
