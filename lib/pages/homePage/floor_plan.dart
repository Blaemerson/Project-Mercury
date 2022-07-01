import 'package:flutter/material.dart';
import 'package:projectmercury/pages/homePage/room_data.dart';
import 'package:projectmercury/resources/locator.dart';
import 'package:projectmercury/widgets/isometric.dart';
import 'package:projectmercury/widgets/room.dart';

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
              bottom: 0,
              child: Actor(
                child: _rooms[5],
              ),
            ),

            /*Kitchen*/
            Positioned(
              bottom: _rooms[5].extendRight,
              child: Actor(
                child: _rooms[3],
              ),
            ),

            /*Diningroom*/
            Positioned(
              bottom: _rooms[5].extendRight + _rooms[3].extendRight,
              child: Actor(
                child: _rooms[4],
              ),
            ),

            /*Bathroom*/
            Positioned(
              left: _rooms[5].extendLeft,
              bottom: 0,
              child: Actor(
                child: _rooms[2],
              ),
            ),

            /*Bedroom*/
            Positioned(
              left: _rooms[5].extendLeft,
              bottom: _rooms[2].extendRight,
              child: Actor(
                child: _rooms[0],
              ),
            ),

            /*Livingroom*/
            Positioned(
              left: _rooms[5].extendLeft,
              bottom: _rooms[2].extendRight + _rooms[0].extendRight,
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
