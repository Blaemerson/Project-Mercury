import 'package:projectmercury/models/furniture.dart';
import 'package:projectmercury/models/slot.dart';
import 'package:projectmercury/pages/homePage/room.dart';

Room bedroom = Room(
  name: 'bedroom',
  width: 200,
  length: 215,
  unlockOrder: 1,
  floorTexture: "assets/textures/woodBoards.jpg",
  wallTexture: "assets/textures/greyWall.jpg",
  items: const [
    Furniture(
      width: 60,
      height: 60,
      xPosition: 25,
      yPosition: 180,
      name: 'door_NE',
    ),
    Furniture(
      width: 50,
      height: 30,
      yPosition: 110,
      xPosition: 70,
      name: 'bedside_table',
    ),
  ],
  slots: [
    Slot(
      room: 'bedroom',
      width: 45,
      height: 20,
      length: 50,
      yPosition: 150,
      xPosition: 50,
      overchargeRate: 0.5,
      doubleCharge: true,
      delay: true,
      items: const [
        Furniture(
          name: 'bed1',
          yPosition: 140,
          xPosition: 70,
          width: 70,
          height: 60,
        ),
        Furniture(
          name: 'bed2',
          yPosition: 140,
          xPosition: 70,
          width: 70,
          height: 60,
        ),
        Furniture(
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
    Furniture(
      width: 100,
      height: 100,
      yPosition: 100,
      xPosition: 0,
      name: 'fireplace',
    ),
    Furniture(
      width: 60,
      height: 60,
      yPosition: 25,
      xPosition: 200,
      name: 'door_NW',
    ),
    Furniture(
      width: 60,
      height: 60,
      yPosition: 200,
      xPosition: 25,
      name: 'door_NE',
    ),
  ],
  slots: [
    Slot(
      room: 'livingroom',
      length: 60,
      width: 60,
      height: 25,
      yPosition: 120,
      xPosition: 170,
      doubleCharge: true,
      items: const [
        Furniture(
          name: 'rugBear',
          xPosition: 150,
          yPosition: 120,
          width: 100,
          height: 100,
        ),
        Furniture(
          name: 'rugRed',
          xPosition: 150,
          yPosition: 120,
          width: 150,
          height: 150,
        ),
        Furniture(
          name: 'yogaMat',
          xPosition: 150,
          yPosition: 120,
          width: 70,
          height: 70,
        ),
        Furniture(
          name: 'coffeeTable',
          xPosition: 170,
          yPosition: 140,
          width: 70,
          height: 70,
        ),
      ],
    ),
    Slot(
      room: 'livingroom',
      length: 35,
      width: 35,
      height: 35,
      yPosition: 70,
      xPosition: 70,
      items: const [
        Furniture(
          name: 'chairCozy',
          xPosition: 50,
          yPosition: 60,
          width: 45,
          height: 60,
        ),
        Furniture(
          name: 'chairWooden',
          xPosition: 50,
          yPosition: 60,
          width: 35,
          height: 50,
        ),
      ],
    ),
    Slot(
      room: 'livingroom',
      length: 40,
      width: 30,
      height: 40,
      yPosition: 40,
      xPosition: 150,
      items: const [
        Furniture(
          name: 'tvVintage',
          xPosition: 150,
          yPosition: 50,
          width: 50,
          height: 40,
        ),
        Furniture(
          name: 'tvMounted',
          yPosition: 0,
          xPosition: 120,
          width: 80,
          height: 50,
        ),
        Furniture(
          name: 'paintingRooster',
          yPosition: 10,
          xPosition: 120,
          width: 50,
          height: 60,
        ),
      ],
    ),
    Slot(
      room: 'livingroom',
      length: 60,
      width: 30,
      height: 40,
      yPosition: 200,
      xPosition: 150,
      items: const [
        Furniture(
          name: 'sofaLeather',
          yPosition: 200,
          xPosition: 185,
          width: 100,
          height: 60,
        ),
        Furniture(
          name: 'sofaRed',
          yPosition: 200,
          xPosition: 185,
          width: 100,
          height: 60,
        ),
        Furniture(
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
    Furniture(
      width: 60,
      height: 60,
      yPosition: 40,
      xPosition: 40,
      name: 'shower',
    ),
    Furniture(
      width: 40,
      height: 40,
      yPosition: 150,
      xPosition: 60,
      name: 'toilet',
    ),
    Furniture(
      width: 40,
      height: 40,
      yPosition: 60,
      xPosition: 150,
      name: 'sink',
    ),
  ],
  slots: [],
);

Room kitchen = const Room(
  name: 'kitchen',
  width: 200,
  length: 215,
  unlockOrder: 4,
  floorTexture: "assets/textures/woodBoards.jpg",
  wallTexture: "assets/textures/floralWall.jpg",
  items: [
    Furniture(
      width: 60,
      height: 60,
      yPosition: 50,
      xPosition: 30,
      name: 'refridgerator',
    ),
    Furniture(
      width: 80,
      height: 60,
      yPosition: 120,
      xPosition: 50,
      name: 'kitchencounters',
    ),
    Furniture(
      width: 60,
      height: 60,
      yPosition: 180,
      xPosition: 20,
      name: 'door_NE',
    ),
  ],
  slots: [],
);

Room diningroom = const Room(
  name: 'diningroom',
  width: 200,
  length: 225,
  unlockOrder: 5,
  floorTexture: "assets/textures/woodBoards.jpg",
  wallTexture: "assets/textures/greyWall.jpg",
  items: [
    Furniture(
      width: 60,
      height: 60,
      yPosition: 170,
      xPosition: 20,
      name: 'door_NE',
    ),
  ],
  slots: [],
);

Room washroom = const Room(
  name: 'washroom',
  width: 200,
  length: 175,
  unlockOrder: 6,
  floorTexture: "assets/textures/bathroomTiles.jpg",
  wallTexture: "assets/textures/greyWall.jpg",
  items: [
    Furniture(
      width: 40,
      height: 40,
      yPosition: 80,
      xPosition: 60,
      name: 'dryer',
    ),
    Furniture(
      width: 40,
      height: 40,
      yPosition: 110,
      xPosition: 60,
      name: 'washer',
    ),
  ],
  slots: [],
);
