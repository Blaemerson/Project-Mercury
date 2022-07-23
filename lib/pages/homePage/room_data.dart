import 'package:flutter/material.dart';
import 'package:projectmercury/models/furniture.dart';
import 'package:projectmercury/models/slot.dart';
import 'package:projectmercury/pages/homePage/room.dart';

// TODO: add back in missing furniture & decorate according to floor plan

// slotID links a Furniture to a Slot
Room bedroom = Room(
  name: 'bedroom',
  width: 200,
  length: 210,
  height: 80,
  roomBehind: true,
  roomBeside: true,
  unlockOrder: 1,
  furniture: const [
    Furniture(
      name: 'doorway',
      direction: 'NE',
      position: Offset(180, 45),
      height: 60,
    ),
    Furniture(
      name: 'modern_tv',
      direction: 'SE',
      position: Offset(200, 125),
      height: 70,
    ),
  ],
  slots: [
    Slot(
      id: 0,
      height: 70,
      visual: 'bed_outline_NW',
      overchargeRate: 0.5,
      doubleCharge: true,
      delay: true,
      acceptables: const [
        Furniture(
          name: 'basic_bed',
          direction: 'NW',
        ),
        Furniture(
          name: 'plush_bed',
          direction: 'NW',
        ),
      ],
      position: const Offset(70, 130),
    ),
    Slot(
      id: 1,
      height: 50,
      visual: 'desk_outline_NE',
      acceptables: const [
        Furniture(
          name: 'desk',
          direction: 'NE',
        ),
      ],
      position: const Offset(140, 55),
    ),
    Slot(
      id: 2,
      height: 40,
      prereq: 1,
      visual: 'desk_chair_outline',
      acceptables: const [
        Furniture(
          name: 'desk_chair',
        ),
      ],
      position: const Offset(150, 100),
    ),
  ],
);

Room livingroom = Room(
  name: 'livingroom',
  roomBehind: true,
  roomBeside: true,
  width: 200,
  length: 240,
  height: 80,
  unlockOrder: 2,
  furniture: const [
    Furniture(
      name: 'doorway',
      direction: 'NE',
      position: Offset(180, 45),
      height: 60,
    ),
    Furniture(
      name: 'doorway',
      direction: 'NW',
      position: Offset(25, 220),
      height: 60,
    ),
  ],
  slots: [
    Slot(
      id: 0,
      height: 40,
      visual: 'outline',
      acceptables: const [
        Furniture(
          name: 'rooster_painting',
          direction: 'NW',
        ),
        Furniture(
          name: 'landscape_painting',
          direction: 'NW',
          height: 50,
        ),
      ],
      position: const Offset(10, 130),
    ),
    Slot(
      id: 1,
      height: 55,
      visual: 'sofa_outline_NW',
      acceptables: const [
        Furniture(
          name: 'basic_sofa',
          direction: 'NW',
        ),
        Furniture(
          name: 'modern_sofa',
          direction: 'NW',
        ),
        Furniture(
          name: 'leather_sofa',
          direction: 'NW',
        ),
        Furniture(
          name: 'plush_sofa',
          direction: 'NW',
        ),
      ],
      position: const Offset(60, 150),
    ),
    Slot(
      id: 2,
      height: 50,
      visual: 'round_rug_outline',
      acceptables: const [
        Furniture(
          name: 'bear_rug',
          direction: 'NE',
        ),
        Furniture(
          name: 'basic_rug',
          height:90,
          position: Offset(140, 120),
        ),
      ],
      position: const Offset(140, 150),
    )
  ],
);

Room bathroom = Room(
  name: 'bathroom',
  roomBeside: true,
  width: 200,
  length: 100,
  height: 80,
  unlockOrder: 3,
  furniture: const [
    Furniture(
      name: 'bathtub',
      direction: 'NE',
      position: Offset(55, 70),
      height: 60,
    ),
    Furniture(
      name: 'toilet',
      direction: 'SW',
      position: Offset(150, 130),
      height: 45,
    ),
  ],
  slots: [
    Slot(
      id: 0,
      height: 35,
      visual: 'round_rug_outline',
      acceptables: const [
        Furniture(
          slotID: 0,
          name: 'bathroom_rug_red',
        ),
        Furniture(
          slotID: 0,
          name: 'bathroom_rug_brown',
        ),
        Furniture(
          slotID: 0,
          name: 'bathroom_rug_white',
        ),
      ],
      position: const Offset(130, 85),
    )
  ],
);

Room kitchen = const Room(
  name: 'kitchen',
  roomBehind: true,
  width: 170,
  length: 190,
  height: 80,
  unlockOrder: 4,
  furniture: [
    Furniture(
      name: 'doorway',
      direction: 'NE',
      position: Offset(160, 45),
      height: 60,
    ),
    Furniture(
      name: 'counter_corner',
      position: Offset(60, 63),
      height: 40,
    ),
    Furniture(
      name: 'counter_counter',
      direction: 'NE',
      position: Offset(84, 64),
      height: 40,
    ),
    Furniture(
      name: 'electric_stove',
      direction: 'NE',
      position: Offset(108, 64),
      height: 40,
    ),
    Furniture(
      name: 'counter_counter',
      direction: 'NW',
      position: Offset(60, 87),
      height: 40,
    ),
    Furniture(
      name: 'counter_counter',
      direction: 'NW',
      position: Offset(60, 111),
      height: 40,
    ),
    Furniture(
      name: 'counter_counter',
      direction: 'NW',
      position: Offset(60, 135),
      height: 40,
    ),
    Furniture(
      name: 'counter_counter',
      direction: 'NW',
      position: Offset(60, 159),
      height: 40,
    ),
    Furniture(
      name: 'fridge',
      direction: 'NW',
      position: Offset(23, 168),
      height: 75,
    ),
    Furniture(
      name: 'counter_counter',
      direction: 'NW',
      position: Offset(60, 220),
      height: 40,
    ),
  ],
);

Room diningroom = const Room(
  name: 'diningroom',
  roomBehind: true,
  width: 170,
  length: 190,
  height: 80,
  unlockOrder: 5,
  furniture: [
    Furniture(
      name: 'doorway',
      direction: 'NE',
      position: Offset(110, 45),
      height: 60,
    ),
  ],
);

Room washroom = const Room(
  name: 'washroom',
  width: 170,
  length: 170,
  height: 80,
  unlockOrder: 6,
  furniture: [],
);
