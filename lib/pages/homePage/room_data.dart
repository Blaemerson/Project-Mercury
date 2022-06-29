import 'package:projectmercury/models/furniture_slot.dart';
import 'package:projectmercury/widgets/room.dart';

class Rooms {
  Room? _room;
  set(Room? room) {
    _room = room;
  }

  Room? get room => _room;

  final List<Room> _rooms = [
    bedroom,
    livingroom,
    bathroom,
    kitchen,
    hall,
    washroom,
  ];
  List<Room> get rooms {
    return _rooms;
  }
}

// variant = null for open slots
// variant = '' for static slots
// Items are (for now), positioned by their percent distance from each wall.
Room bedroom = Room(
  name: 'bedroom',
  extendLeft: 200,
  extendRight: 150,
  unlockOrder: 1,
  floorTexture: "assets/textures/woodBoards.jpg",
  wallTexture: "assets/textures/greyWall.jpg",
  items: [
    FurnitureSlot(
      width: 60,
      height: 60,
      distanceFromLeft: .02,
      distanceFromRight: .5,
      type: 'door_NW',
      variant: '',
    ),
    FurnitureSlot(
      width: 70,
      height: 70,
      distanceFromLeft: .5,
      distanceFromRight: .30,
      type: 'bed',
      variant: null,
    ),
    FurnitureSlot(
      width: 60,
      height: 30,
      distanceFromLeft: .7,
      distanceFromRight: .3,
      type: 'bedside_table',
      variant: '',
    ),
  ],
);

Room livingroom = Room(
  extendLeft: 250,
  extendRight: 250,
  unlockOrder: 2,
  floorTexture: 'assets/textures/woodBoards.jpg',
  wallTexture: 'assets/textures/floralWall.jpg',
  name: 'livingroom',
  items: [
    FurnitureSlot(
      width: 60,
      height: 60,
      distanceFromLeft: .02,
      distanceFromRight: .3,
      type: 'door_NW',
      variant: '',
    ),
    FurnitureSlot(
      width: 70,
      height: 70,
      distanceFromLeft: .1,
      distanceFromRight: .7,
      type: 'tv',
      variant: '',
    ),
    FurnitureSlot(
      width: 60,
      height: 60,
      distanceFromLeft: .6,
      distanceFromRight: .23,
      type: 'sofa',
      variant: null,
    ),
    FurnitureSlot(
      width: 150,
      height: 150,
      distanceFromLeft: .5,
      distanceFromRight: .5,
      type: 'rug',
      variant: null,
    ),
  ],
);

Room bathroom = Room(
  name: 'bathroom',
  extendLeft: 150,
  extendRight: 200,
  unlockOrder: 3,
  floorTexture: "assets/textures/bathroomTiles.jpg",
  wallTexture: "assets/textures/greyWall.jpg",
  items: [
    FurnitureSlot(
      width: 60,
      height: 60,
      distanceFromLeft: .13,
      distanceFromRight: .10,
      type: 'shower',
      variant: '',
    ),
    FurnitureSlot(
      width: 40,
      height: 40,
      distanceFromLeft: .8,
      distanceFromRight: .23,
      type: 'toilet',
      variant: '',
    ),
    FurnitureSlot(
      width: 40,
      height: 40,
      distanceFromLeft: .23,
      distanceFromRight: .7,
      type: 'sink',
      variant: '',
    ),
  ],
);

Room kitchen = Room(
  name: 'kitchen',
  extendLeft: 150,
  extendRight: 200,
  unlockOrder: 4,
  floorTexture: "assets/textures/woodBoards.jpg",
  wallTexture: "assets/textures/floralWall.jpg",
  items: [
    FurnitureSlot(
      width: 60,
      height: 60,
      distanceFromLeft: .15,
      distanceFromRight: .08,
      type: 'refridgerator',
      variant: null,
    ),
    FurnitureSlot(
      width: 80,
      height: 60,
      distanceFromLeft: .55,
      distanceFromRight: .15,
      type: 'kitchencounters',
      variant: '',
    ),
  ],
);

Room hall = Room(
  name: 'hall',
  extendLeft: 150,
  extendRight: 300,
  unlockOrder: 5,
  floorTexture: "assets/textures/woodBoards.jpg",
  wallTexture: "assets/textures/greyWall.jpg",
  items: [
    FurnitureSlot(
      width: 60,
      height: 60,
      distanceFromLeft: .7,
      distanceFromRight: .02,
      type: 'door_NE',
      variant: '',
    ),
    FurnitureSlot(
      width: 60,
      height: 60,
      distanceFromLeft: .02,
      distanceFromRight: .7,
      type: 'door_NW',
      variant: '',
    ),
  ],
);

Room washroom = Room(
  name: 'washroom',
  extendLeft: 100,
  extendRight: 150,
  unlockOrder: 6,
  floorTexture: "assets/textures/bathroomTiles.jpg",
  wallTexture: "assets/textures/greyWall.jpg",
  items: [
    FurnitureSlot(
      width: 40,
      height: 40,
      distanceFromLeft: .4,
      distanceFromRight: .25,
      type: 'dryer',
      variant: '',
    ),
    FurnitureSlot(
      width: 40,
      height: 40,
      distanceFromLeft: .6,
      distanceFromRight: .25,
      type: 'washer',
      variant: '',
    ),
  ],
);
