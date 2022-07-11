import 'package:projectmercury/models/furniture_slot.dart';
import 'package:projectmercury/widgets/furniture_card.dart';
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
    diningroom,
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
  width: 200,
  length: 215,
  unlockOrder: 1,
  floorTexture: "assets/textures/woodBoards.jpg",
  wallTexture: "assets/textures/greyWall.jpg",
  items: const [
    FurnitureCard(
      width: 60,
      height: 60,
      xPosition: 25,
      yPosition: 180,
      name: 'door_NE',
    ),
    FurnitureCard(
      width: 50,
      height: 30,
      yPosition: 110,
      xPosition: 70,
      name: 'bedside_table',
    ),
  ],
  openSlots: [
    FurnitureSlot(
      room: 'bedroom',
      width: 45,
      height: 20,
      length: 50,
      yPosition: 150,
      xPosition: 60,
      overchargeRate: 0.5,
      items: const [
        FurnitureCard(
          name: 'bed1',
          yPosition: 140,
          xPosition: 70,
          width: 70,
          height: 60,
        ),
        FurnitureCard(
          name: 'bed2',
          yPosition: 140,
          xPosition: 70,
          width: 70,
          height: 60,
        ),
        FurnitureCard(
          name: 'bed3',
          yPosition: 140,
          xPosition: 70,
          width: 70,
          height: 60,
        ),
      ],
    ),
  ],
);

Room livingroom = Room(
  width: 200,
  length: 250,
  unlockOrder: 2,
  floorTexture: 'assets/textures/woodBoards.jpg',
  wallTexture: 'assets/textures/floralWall.jpg',
  name: 'livingroom',
  items: const [
    FurnitureCard(
      width: 100,
      height: 100,
      yPosition: 100,
      xPosition: 0,
      name: 'fireplace',
    ),
    FurnitureCard(
      width: 60,
      height: 60,
      yPosition: 25,
      xPosition: 200,
      name: 'door_NW',
    ),
    FurnitureCard(
      width: 60,
      height: 60,
      yPosition: 200,
      xPosition: 25,
      name: 'door_NE',
    ),
  ],
  openSlots: [
    FurnitureSlot(
      room: 'livingroom',
      length: 90,
      width: 90,
      height: 20,
      yPosition: 120,
      xPosition: 150,
      doubleCharge: true,
      items: const [
        FurnitureCard(
            name: 'rugBear',
            xPosition: 150,
            yPosition: 120,
            width: 100,
            height: 100),
        FurnitureCard(
            name: 'rugRed',
            xPosition: 150,
            yPosition: 120,
            width: 150,
            height: 150),
        FurnitureCard(
            name: 'yogaMat',
            xPosition: 150,
            yPosition: 120,
            width: 70,
            height: 70),
        FurnitureCard(
            name: 'coffeeTable',
            xPosition: 170,
            yPosition: 140,
            width: 70,
            height: 70),
      ],
    ),
    FurnitureSlot(
      room: 'livingroom',
      length: 40,
      width: 40,
      height: 40,
      yPosition: 40,
      xPosition: 40,
      items: const [
        FurnitureCard(
          name: 'chairCozy',
          xPosition: 50,
          yPosition: 60,
          width: 45,
          height: 60,
        ),
        FurnitureCard(
          name: 'chairWooden',
          xPosition: 50,
          yPosition: 60,
          width: 35,
          height: 50,
        ),
      ],
    ),
    FurnitureSlot(
      room: 'livingroom',
      length: 50,
      width: 25,
      height: 50,
      yPosition: 10,
      xPosition: 130,
      items: const [
        FurnitureCard(
          name: 'tvVintage',
          xPosition: 150,
          yPosition: 50,
          width: 50,
          height: 40,
        ),
        FurnitureCard(
          name: 'tvMounted',
          yPosition: 0,
          xPosition: 120,
          width: 80,
          height: 50,
        ),
        FurnitureCard(
          name: 'paintingRooster',
          yPosition: 10,
          xPosition: 120,
          width: 50,
          height: 60,
        ),
      ],
    ),
    FurnitureSlot(
      room: 'livingroom',
      length: 60,
      width: 30,
      height: 40,
      yPosition: 200,
      xPosition: 150,
      items: const [
        FurnitureCard(
          name: 'sofaLeather',
          yPosition: 200,
          xPosition: 185,
          width: 100,
          height: 60,
        ),
        FurnitureCard(
          name: 'sofaRed',
          yPosition: 200,
          xPosition: 185,
          width: 100,
          height: 60,
        ),
        FurnitureCard(
          name: 'sofaModern',
          yPosition: 200,
          xPosition: 185,
          width: 100,
          height: 60,
        ),
      ],
    ),
  ],
);

Room bathroom = const Room(
  name: 'bathroom',
  width: 200,
  length: 150,
  unlockOrder: 3,
  floorTexture: "assets/textures/bathroomTiles.jpg",
  wallTexture: "assets/textures/greyWall.jpg",
  items: [
    FurnitureCard(
      width: 60,
      height: 60,
      yPosition: 40,
      xPosition: 40,
      name: 'shower',
    ),
    FurnitureCard(
      width: 40,
      height: 40,
      yPosition: 150,
      xPosition: 60,
      name: 'toilet',
    ),
    FurnitureCard(
      width: 40,
      height: 40,
      yPosition: 60,
      xPosition: 150,
      name: 'sink',
    ),
  ],
  openSlots: [],
);

Room kitchen = const Room(
  name: 'kitchen',
  width: 200,
  length: 215,
  unlockOrder: 4,
  floorTexture: "assets/textures/woodBoards.jpg",
  wallTexture: "assets/textures/floralWall.jpg",
  items: [
    FurnitureCard(
      width: 60,
      height: 60,
      yPosition: 50,
      xPosition: 30,
      name: 'refridgerator',
    ),
    FurnitureCard(
      width: 80,
      height: 60,
      yPosition: 120,
      xPosition: 50,
      name: 'kitchencounters',
    ),
    FurnitureCard(
      width: 60,
      height: 60,
      yPosition: 180,
      xPosition: 20,
      name: 'door_NE',
    ),
  ],
  openSlots: [],
);

Room diningroom = const Room(
  name: 'diningroom',
  width: 200,
  length: 225,
  unlockOrder: 5,
  floorTexture: "assets/textures/woodBoards.jpg",
  wallTexture: "assets/textures/greyWall.jpg",
  items: [
    FurnitureCard(
      width: 60,
      height: 60,
      yPosition: 170,
      xPosition: 20,
      name: 'door_NE',
    ),
  ],
  openSlots: [],
);

Room washroom = const Room(
  name: 'washroom',
  width: 200,
  length: 175,
  unlockOrder: 6,
  floorTexture: "assets/textures/bathroomTiles.jpg",
  wallTexture: "assets/textures/greyWall.jpg",
  items: [
    FurnitureCard(
      width: 40,
      height: 40,
      yPosition: 80,
      xPosition: 60,
      name: 'dryer',
    ),
    FurnitureCard(
      width: 40,
      height: 40,
      yPosition: 110,
      xPosition: 60,
      name: 'washer',
    ),
  ],
  openSlots: [],
);
