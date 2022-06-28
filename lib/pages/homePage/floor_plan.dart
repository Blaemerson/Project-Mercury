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
    // TODO: finalize floor layout
    // Just experimenting for now, but at least positioning rooms is easier
    return SizedBox(
      width: 800,
      height: 800,
      child: IsometricView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [

            /*Bathroom*/
            Positioned(
              left: 0,
              bottom: 0,
              child: Actor(
                child: _rooms[2],
              ),
            ),

            /*Bedroom*/
            Positioned(
              left: _rooms[2].extendLeft,
              bottom: 0,
              child: Actor(
                child: _rooms[0],
              ),
            ),

            /*Washroom*/
            Positioned(
              left: _rooms[2].extendLeft + _rooms[0].extendLeft,
              bottom: 0,
              child: Actor(
                child: _rooms[5],
              ),
            ),

            /*Kitchen*/
            Positioned(
              left: 0,
              bottom: _rooms[2].extendRight,
              child: Actor(
                child: _rooms[3],
              ),
            ),

            /*Hallway*/
            Positioned(
              left: _rooms[2].extendLeft,
              bottom: _rooms[0].extendRight,
              child: Actor(
                child: _rooms[4],
              ),
            ),

            /*Livingroom*/
            Positioned(
              left: _rooms[2].extendLeft + _rooms[4].extendLeft,
              bottom: _rooms[0].extendRight,
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
