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
    return Center(
      child: IsometricView(
        child: Container(
          color: Colors.red,
          width: _rooms[0].length + _rooms[1].length + _rooms[2].length + 100,
          height: _rooms[0].width + _rooms[3].width + 100,
          child: Stack(
            children: [
              /*Livingroom*/
              Positioned(
                right:0,
                bottom: 0 + _rooms[1].width,
                child: Actor(
                  child: _rooms[5],
                ),
              ),
              Positioned(
                right: _rooms[5].length,
                bottom: 0 + _rooms[1].width,
                child: Actor(
                  child: _rooms[3],
                ),
              ),
              Positioned(
                right: _rooms[3].length + _rooms[5].length,
                bottom: 0 + _rooms[1].width,
                child: Actor(
                  child: _rooms[4],
                ),
              ),
              /*Bathroom*/
              Positioned(
                bottom: 0,
                right: 0,
                child: Actor(
                  child: _rooms[2],
                ),
              ),
              /*Bedroom*/
              Positioned(
                bottom: 0,
                right:_rooms[2].length,
                child: Actor(
                  child: _rooms[0],
                ),
              ),
              /*Livingroom*/
              Positioned(
                bottom: 0,
                right:_rooms[2].length + _rooms[0].length,
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
