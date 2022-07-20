import 'package:flutter/material.dart';
import 'package:projectmercury/pages/homePage/isometric.dart';
import 'package:projectmercury/pages/homePage/room.dart';
import 'package:projectmercury/resources/event_controller.dart';
import 'package:projectmercury/resources/locator.dart';

class FloorPlan extends StatelessWidget {
  const FloorPlan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Room> _rooms = locator.get<EventController>().rooms;
    return SizedBox(
      width: 700,
      height: 705,
      child: Center(
        child: IsometricView(
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              /*Washroom*/
              Positioned(
                left: 90,
                bottom: 0,
                child: Actor(
                  child: _rooms[5],
                ),
              ),

              /*Kitchen*/
              Positioned(
                left: 90,
                bottom: _rooms[5].length,
                child: Actor(
                  child: _rooms[3],
                ),
              ),

              /*Diningroom*/
              Positioned(
                left: 90,
                bottom: _rooms[5].length + _rooms[3].length,
                child: Actor(
                  child: _rooms[4],
                ),
              ),

              /*Bathroom*/
              Positioned(
                left: _rooms[5].width + 90,
                bottom: 0,
                child: Actor(
                  child: _rooms[2],
                ),
              ),
              /*Bedroom*/
              Positioned(
                left: _rooms[3].width + 90,
                bottom: _rooms[2].length,
                child: Actor(
                  child: _rooms[0],
                ),
              ),
              /*Livingroom*/
              Positioned(
                left: _rooms[4].width + 90,
                bottom: _rooms[0].length + _rooms[2].length,
                child: Actor(
                  child: _rooms[1],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
