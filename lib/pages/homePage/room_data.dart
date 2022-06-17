import 'package:projectmercury/models/furniture_slot.dart';
import 'package:projectmercury/widgets/room.dart';

class Rooms {
  List<Room> get rooms {
    return [
      bedroom,
      livingroom,
      bathroom,
      kitchen,
    ];
  }

  // TODO: Make sure all items are the right scale
  Room bedroom = Room(
    name: 'bedroom',
    width: 300,
    depth: 300,
    floorTexture: "assets/textures/light_wood.jpg",
    wallTexture: "assets/textures/grey_wall.jpg",
    items: [
      FurnitureSlot(
        width: 130,
        height: 130,
        positionX: 0,
        positionY: 140,
        type: 'doorway_NW',
        variant: '',
      ),
      FurnitureSlot(
        width: 130,
        height: 130,
        positionX: 200,
        positionY: 120,
        type: 'bed',
        variant: null,
      ),
    ],
  );

  Room bathroom = Room(
    name: 'bathroom',
    width: 250,
    depth: 250,
    floorTexture: "assets/textures/light_wood.jpg",
    wallTexture: "assets/textures/grey_wall.jpg",
    items: [
      FurnitureSlot(
        width: 130,
        height: 130,
        positionX: 190,
        positionY: 140,
        type: 'doorway_NE',
        variant: '',
      ),
      FurnitureSlot(
        width: 70,
        height: 70,
        positionX: 155,
        positionY: 150,
        type: 'toilet',
        variant: ''
      ),
    ],
  );

  Room kitchen = Room(
    name: 'kitchen',
    width: 350,
    depth: 300,
    floorTexture: "assets/textures/wood_floor.jpg",
    wallTexture: "assets/textures/floral_wall.jpg",
    items: [
      FurnitureSlot(
        width: 100,
        height: 120,
        positionX: 190,
        positionY: 220,
        type: 'refridgerator',
        variant: '2',
      ),
      FurnitureSlot(
        width: 80,
        height: 80,
        positionX: 245,
        positionY: 185,
        type: 'kitchen_cabinet',
        variant: '',
      ),
      FurnitureSlot(
        width: 80,
        height: 80,
        positionX: 279,
        positionY: 165,
        type: 'kitchen_sink',
        variant: '',
      ),
    ],
  );

  Room livingroom = Room(
    name: 'livingroom',
    width: 250,
    depth: 300,
    floorTexture: "assets/textures/wood_floor.jpg",
    wallTexture: "assets/textures/floral_wall.jpg",
    items: [
      FurnitureSlot(
        width: 130,
        height: 130,
        positionX: 90,
        positionY: 175,
        type: 'doorway_NW',
        variant: '',
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
        width: 200,
        height: 100,
        positionX: 220,
        positionY: 110,
        type: 'couch',
        variant: null,
      ),
      FurnitureSlot(
        width: 70,
        height: 70,
        positionX: 200,
        positionY: 180,
        type: 'chair',
        variant: null,
      ),
    ],
  );
}
