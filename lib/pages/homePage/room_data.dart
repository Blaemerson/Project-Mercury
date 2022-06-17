import 'package:projectmercury/models/furniture_slot.dart';
import 'package:projectmercury/widgets/room.dart';

class Rooms {
  List<Room> get rooms {
    return [
      bedroom,
      livingroom,
    ];
  }

  Room bedroom = Room(
    name: 'bedroom',
    width: 300,
    depth: 300,
    floorTexture: "assets/light_wood.jpg",
    wallTexture: "assets/grey_wall.jpg",
    items: [
      FurnitureSlot(
        width: 100,
        height: 100,
        positionX: 50,
        positionY: 120,
        type: 'table',
        variant: null,
      )
    ],
  );
  Room livingroom = Room(
    name: 'livingroom',
    width: 250,
    depth: 300,
    items: [
      FurnitureSlot(
        width: 100,
        height: 100,
        positionX: 170,
        positionY: 20,
        type: 'table',
        variant: null,
      ),
      FurnitureSlot(
        width: 150,
        height: 150,
        positionX: 0,
        positionY: 95,
        type: 'fireplace',
        variant: '',
      ),
      FurnitureSlot(
        width: 100,
        height: 100,
        positionX: 140,
        positionY: 170,
        type: 'chair',
        variant: null,
      ),
    ],
  );
}
