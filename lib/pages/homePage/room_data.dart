import 'package:flutter/material.dart';
/* import 'package:projectmercury/models/furniture.dart'; */
/* import 'package:projectmercury/models/slot.dart'; */
import 'package:projectmercury/pages/homePage/room.dart';

// TODO: possibly store some of this in json

// slotID links a Furniture to a Slot
Room bedroom = Room(
  name: 'bedroom',
  width: 200,
  length: 210,
  height: 100,
  roomBehind: true,
  roomBeside: true,
  unlockOrder: 1,
  furniture: const [
    Furniture(
      name: 'doorway',
      direction: 'NE',
      position: Offset(200, 55),
      size: Size(40, 60),
    ),
    Furniture(
      slotID: 0,
      name: 'basic_bed',
      direction: 'NW',
      position: Offset(90, 150),
      size: Size(90, 85),
    ),
    Furniture(
      slotID: 0,
      name: 'plush_bed',
      direction: 'NW',
      position: Offset(90, 150),
      size: Size(90, 85),
    ),
    Furniture(
      slotID: 1,
      name: 'desk',
      direction: 'NE',
      position: Offset(160, 70),
      size: Size(70, 50),
    ),
    Furniture(
      slotID: 2,
      name: 'modern_tv',
      direction: 'SE',
      position: Offset(220, 145),
      size: Size(70, 70),
    ),
    Furniture(
      slotID: 3,
      name: 'square_lamp',
      direction: 'NE',
      position: Offset(50, 70),
      size: Size(30, 70),
    ),
    Furniture(
      slotID: 3,
      name: 'potted_plant',
      direction: 'NE',
      position: Offset(60, 70),
      size: Size(30, 50),
    ),
  ],
  slots: [
    Slot(
      id: 0,
      size: const Size(90, 85),
      outline: 'bed_outline_NW',
      acceptables: ['basic_bed', 'plush_bed'],
      position: const Offset(90, 150),
    ),
    Slot(
      id: 1,
      size: const Size(70, 65),
      outline: 'bed_outline_NW',
      acceptables: ['desk'],
      position: const Offset(160, 70),
    ),
    Slot(
      id: 2,
      size: const Size(70, 70),
      outline: 'tv_outline_SE',
      acceptables: ['modern_tv'],
      position: const Offset(220, 145),
    ),
    Slot(
      id: 3,
      size: const Size(30, 70),
      outline: 'outline_tall',
      acceptables: ['potted_plant', 'square_lamp'],
      position: const Offset(50, 70),
    ),
  ],
);

Room livingroom = Room(
  name: 'livingroom',
  roomBehind: true,
  roomBeside: true,
  width: 200,
  length: 240,
  height: 100,
  unlockOrder: 2,
  furniture: const [
    Furniture(
      slotID: 0,
      name: 'basic_sofa',
      direction: 'NW',
      position: Offset(80, 160),
      size: Size(70, 60),
    ),
    Furniture(
      slotID: 0,
      name: 'modern_sofa',
      direction: 'NW',
      position: Offset(80, 160),
      size: Size(70, 60),
    ),
    Furniture(
      slotID: 0,
      name: 'leather_sofa',
      direction: 'NW',
      position: Offset(80, 160),
      size: Size(70, 60),
    ),
    Furniture(
      slotID: 0,
      name: 'plush_sofa',
      direction: 'NW',
      position: Offset(80, 160),
      size: Size(70, 60),
    ),
  ],
  slots: [
    Slot(
      id: 0,
      size: const Size(70, 60),
      outline: 'sofa_outline_NW',
      acceptables: ['plush_sofa', 'leather_sofa', 'modern_sofa', 'basic_sofa', ],
      position: const Offset(80, 180),
    )
  ],
);


Room bathroom = const Room(
  name: 'bathroom',
  roomBeside: true,
  width: 200,
  length: 100,
  height: 100,
  unlockOrder: 3,
  furniture: [],
);

Room kitchen = const Room(
  name: 'kitchen',
  roomBehind: true,
  width: 170,
  length: 190,
  height: 100,
  unlockOrder: 4,
  furniture: [],
);

Room diningroom = const Room(
  name: 'diningroom',
  roomBehind: true,
  width: 170,
  length: 190,
  height: 100,
  unlockOrder: 5,
  furniture: [],
);

Room washroom = const Room(
  name: 'washroom',
  width: 170,
  length: 170,
  height: 100,
  unlockOrder: 6,
  furniture: [],
);
