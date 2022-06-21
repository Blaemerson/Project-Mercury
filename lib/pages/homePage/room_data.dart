import 'package:projectmercury/models/furniture_slot.dart';
import 'package:projectmercury/resources/event_controller.dart';
import 'package:projectmercury/resources/locator.dart';
import 'package:projectmercury/widgets/room.dart';

class Rooms {
  Room? _room;
  set(Room? room) {
    _room = room;
  }

  Room? get room => _room;

  final List<Room> _rooms = [
    bedroom,
    bathroom,
    kitchen,
    livingroom,
    diningroom,
    hall,
    washroom,
    garage,
  ];
  List<Room> get rooms {
    return _rooms;
  }
}

// variant = null for open slots
// variant = '' for static slots
// TODO: Make sure all items are the right scale
Room bedroom = Room(
  name: 'bedroom',
  width: 250,
  depth: 250,
  unlockOrder: 1,
  floorTexture: "assets/textures/lightWood.jpg",
  wallTexture: "assets/textures/greyWall.jpg",
  items: [
    FurnitureSlot(
      width: 100,
      height: 100,
      positionX: 0,
      positionY: 120,
      type: 'doorway_NW',
      variant: '',
    ),
    FurnitureSlot(
      width: 120,
      height: 120,
      positionX: 160,
      positionY: 90,
      type: 'bed',
      variant: null,
    ),
    FurnitureSlot(
      width: 60,
      height: 60,
      positionX: 260,
      positionY: 110,
      type: 'cabinetBedTable_NE',
      variant: '',
    ),
  ],
);

Room bathroom = Room(
  name: 'bathroom',
  width: 200,
  depth: 250,
  unlockOrder: 2,
  floorTexture: "assets/textures/bathroomTiles.jpg",
  wallTexture: "assets/textures/greyWall.jpg",
  items: [
    FurnitureSlot(
      width: 100,
      height: 100,
      positionX: 125,
      positionY: 140,
      type: 'shower_NW',
      variant: '',
    ),
    FurnitureSlot(
      width: 60,
      height: 60,
      positionX: 230,
      positionY: 100,
      type: 'toilet_NE',
      variant: '',
    ),
    FurnitureSlot(
      width: 60,
      height: 60,
      positionX: 10,
      positionY: 85,
      type: 'bathroomSink_NW',
      variant: '',
    ),
  ],
);

Room kitchen = Room(
  name: 'kitchen',
  width: 350,
  depth: 250,
  unlockOrder: 3,
  floorTexture: "assets/textures/bathroomTiles.jpg",
  wallTexture: "assets/textures/greyWall.jpg",
  items: [
    FurnitureSlot(
      width: 110,
      height: 110,
      positionX: 170,
      positionY: 195,
      type: 'refridgerator',
      variant: null,
    ),
    FurnitureSlot(
      width: 75,
      height: 75,
      positionX: 215,
      positionY: 165,
      type: 'kitchenCabinet_NE',
      variant: '',
    ),
    FurnitureSlot(
      width: 75,
      height: 75,
      positionX: 247,
      positionY: 147,
      type: 'kitchenSink_NE',
      variant: '',
    ),
  ],
);

Room livingroom = Room(
  name: 'livingroom',
  width: 300,
  depth: 250,
  unlockOrder: 4,
  floorTexture: "assets/textures/woodBoards.jpg",
  wallTexture: "assets/textures/floralWall.jpg",
  items: [
    FurnitureSlot(
      width: 100,
      height: 100,
      positionX: 10,
      positionY: 140,
      type: 'doorway_NW',
      variant: '',
    ),
    FurnitureSlot(
      width: 100,
      height: 100,
      positionX: 180,
      positionY: 180,
      type: 'doorway_NE',
      variant: '',
    ),
    FurnitureSlot(
      width: 100,
      height: 100,
      positionX: 270,
      positionY: 90,
      type: 'couch',
      variant: null,
    ),
  ],
);

Room diningroom = Room(
  name: 'diningroom',
  width: 500,
  depth: 250,
  unlockOrder: 5,
  floorTexture: "assets/textures/woodBoards.jpg",
  wallTexture: "assets/textures/greyWall.jpg",
  items: [
    FurnitureSlot(
      width: 100,
      height: 100,
      positionX: 200,
      positionY: 255,
      type: 'doorway_NE',
      variant: '',
    ),
    FurnitureSlot(
      width: 100,
      height: 100,
      positionX: 50,
      positionY: 255,
      type: 'doorway_NW',
      variant: '',
    ),
  ],
);

Room hall = Room(
  name: 'hall',
  width: 550,
  depth: 250,
  unlockOrder: 6,
  floorTexture: "assets/textures/lightWood.jpg",
  wallTexture: "assets/textures/greyWall.jpg",
  items: [
    FurnitureSlot(
      width: 100,
      height: 100,
      positionX: 70,
      positionY: 290,
      type: 'doorway_NW',
      variant: '',
    ),
    FurnitureSlot(
      width: 100,
      height: 100,
      positionX: 300,
      positionY: 220,
      type: 'doorway_NE',
      variant: '',
    ),
    FurnitureSlot(
      width: 100,
      height: 100,
      positionX: 460,
      positionY: 130,
      type: 'doorway_NE',
      variant: '',
    ),
  ],
);

Room washroom = Room(
  name: 'washroom',
  width: 150,
  depth: 250,
  unlockOrder: 7,
  floorTexture: "assets/textures/bathroomTiles.jpg",
  wallTexture: "assets/textures/greyWall.jpg",
  items: [
    FurnitureSlot(
      width: 75,
      height: 75,
      positionX: 160,
      positionY: 112,
      type: 'dryer_NE',
      variant: '',
    ),
    FurnitureSlot(
      width: 75,
      height: 75,
      positionX: 200,
      positionY: 90,
      type: 'washer_NE',
      variant: '',
    ),
  ],
);

Room garage = Room(
  name: 'garage',
  width: 300,
  depth: 250,
  unlockOrder: 8,
  floorTexture: "assets/textures/bathroomTiles.jpg",
  wallTexture: "assets/textures/greyWall.jpg",
  items: [
  ],
);


