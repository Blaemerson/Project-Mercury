import 'package:flutter/material.dart';
/* import 'package:projectmercury/models/furniture.dart'; */
/* import 'package:projectmercury/models/slot.dart'; */
import 'package:projectmercury/pages/homePage/room.dart';

// TODO: possibly store some of this in json

// slotID links a Furniture to a Slot
Room bedroom = Room(
  name: 'bedroom',
  width: 200,
  length: 200,
  height: 100,
  unlockOrder: 1,
  furniture: const [
    Furniture(
      slotID: 0,
      name: 'basic_bed',
      direction: 'NW',
      position: Offset(90, 160),
      size: Size(70, 65),
    ),
    Furniture(
      slotID: 0,
      name: 'plush_bed',
      direction: 'NW',
      position: Offset(90, 160),
      size: Size(70, 65),
    ),
  ],
  slots: [
    Slot(
      id: 0,
      size: const Size(70, 65),
      outline: 'bed_outline_NW',
      acceptables: ['basic_bed', 'plush_bed'],
      position: const Offset(90, 180),
    )
  ],
);

Room livingroom = Room(
  name: 'livingroom',
  width: 200,
  length: 250,
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
  width: 200,
  length: 150,
  height: 100,
  unlockOrder: 3,
  furniture: [],
);

Room kitchen = const Room(
  name: 'kitchen',
  width: 200,
  length: 215,
  height: 100,
  unlockOrder: 4,
  furniture: [],
);

Room diningroom = const Room(
  name: 'diningroom',
  width: 200,
  length: 225,
  height: 100,
  unlockOrder: 5,
  furniture: [],
);

Room washroom = const Room(
  name: 'washroom',
  width: 200,
  length: 175,
  height: 100,
  unlockOrder: 6,
  furniture: [],
);
