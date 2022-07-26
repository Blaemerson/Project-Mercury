import 'package:flutter/material.dart';
import 'package:projectmercury/models/furniture.dart';
import 'package:projectmercury/models/scam.dart';
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
  items: [
    const Furniture(
      name: 'doorway',
      direction: 'NE',
      position: Offset(180, 45),
      height: 60,
    ),
    Slot(
      id: 0,
      height: 55,
      visual: 'outline_tall',
      acceptables: const [
        Furniture(
          name: 'square_lamp',
        ),
        Furniture(
          name: 'potted_plant',
        ),
      ],
      position: const Offset(40, 55),
    ),
    Slot(
      id: 1,
      prereq: 2,
      height: 35,
      visual: 'outline',
      acceptables: const [
        Furniture(name: 'bedside_table'),
      ],
      position: const Offset(65, 115),
    ),
    Slot(
      id: 2,
      height: 70,
      visual: 'bed_outline_NW',
      scam: const Scam(
        overchargeRate: 0.5,
        doubleCharge: true,
        delay: true,
      ),
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
      prereq: 2,
      height: 35,
      visual: 'outline',
      acceptables: const [
        Furniture(name: 'bedside_table'),
      ],
      position: const Offset(65, 205),
    ),
    Slot(
      id: 4,
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
      id: 5,
      height: 40,
      prereq: 4,
      visual: 'desk_chair_outline',
      acceptables: const [
        Furniture(
          name: 'desk_chair',
        ),
      ],
      position: const Offset(150, 90),
    ),
    Slot(
      id: 6,
      height: 30,
      prereq: 4,
      visual: 'outline',
      acceptables: const [
        Furniture(
          name: 'computer',
          direction: 'NE',
        ),
      ],
      position: const Offset(130, 45),
    ),
    const Furniture(
      name: 'modern_tv',
      direction: 'SE',
      position: Offset(210, 130),
      height: 70,
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
  items: [
    const Furniture(
      name: 'doorway',
      direction: 'NE',
      position: Offset(180, 45),
      height: 60,
    ),
    const Furniture(
      name: 'doorway',
      direction: 'NW',
      position: Offset(25, 230),
      height: 60,
    ),
    Slot(
      id: 6,
      height: 40,
      visual: 'outline_wall_NW',
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
      id: 7,
      height: 65,
      visual: 'sofa_outline_NW',
      acceptables: const [
        Furniture(
          name: 'basic_sofa',
          direction: 'NW',
        ),
        Furniture(
          name: 'plush_sofa',
          height: 65,
          direction: 'NW',
        ),
      ],
      position: const Offset(60, 145),
    ),
    Slot(
      id: 8,
      height: 50,
      visual: 'round_rug_outline',
      acceptables: const [
        Furniture(
          name: 'bear_rug',
          direction: 'NE',
          height: 60,
          position: Offset(140, 155),
        ),
        Furniture(
          name: 'basic_rug',
          height: 90,
          position: Offset(140, 125),
        ),
        Furniture(
          name: 'modern_coffee_table',
          height: 50,
          position: Offset(145, 170),
        ),
        Furniture(
          name: 'classic_coffee_table',
          height: 50,
          position: Offset(145, 170),
        ),
      ],
      position: const Offset(150, 155),
    ),
    Slot(
      id: 10,
      height: 60,
      visual: 'outline_wall_NE',
      acceptables: const [
        Furniture(
          name: 'fireplace',
          direction: 'NE',
          height: 80,
          position: Offset(100, 35),
        ),
      ],
      position: const Offset(120, 45),
    ),
    Slot(
      id: 9,
      height: 50,
      visual: 'loveseat_outline_NE',
      acceptables: const [
        Furniture(
          name: 'basic_loveseat',
          direction: 'NE',
        ),
        Furniture(
          name: 'plush_loveseat',
          direction: 'NE',
        ),
      ],
      position: const Offset(145, 105),
    ),
  ],
);

Room bathroom = Room(
  name: 'bathroom',
  roomBeside: true,
  width: 200,
  length: 100,
  height: 80,
  unlockOrder: 3,
  items: [
    Slot(
      id: 9,
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
    ),
    const Furniture(
      name: 'bathtub',
      direction: 'NE',
      position: Offset(55, 70),
      height: 60,
    ),
    const Furniture(
      name: 'toilet',
      direction: 'SW',
      position: Offset(150, 130),
      height: 45,
    ),
  ],
);

Room kitchen = const Room(
  name: 'kitchen',
  roomBehind: true,
  width: 170,
  length: 190,
  height: 80,
  unlockOrder: 4,
  items: [
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
      name: 'counter',
      direction: 'NE',
      position: Offset(84, 64),
      height: 40,
    ),
    Furniture(
      name: 'window',
      direction: 'NW',
      position: Offset(10, 60),
      height: 45,
    ),
    Furniture(
      name: 'electric_stove',
      direction: 'NE',
      position: Offset(108, 64),
      height: 40,
    ),
    Furniture(
      name: 'counter',
      direction: 'NW',
      position: Offset(60, 87),
      height: 40,
    ),
    Furniture(
      name: 'counter',
      direction: 'NW',
      position: Offset(60, 111),
      height: 40,
    ),
    Furniture(
      name: 'counter',
      direction: 'NW',
      position: Offset(60, 135),
      height: 40,
    ),
    Furniture(
      name: 'counter',
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
      name: 'counter',
      direction: 'NW',
      position: Offset(60, 220),
      height: 40,
    ),
  ],
);

Room diningroom = Room(
  name: 'diningroom',
  roomBehind: true,
  width: 170,
  length: 190,
  height: 80,
  unlockOrder: 5,
  items: [
    const Furniture(
      name: 'window',
      direction: 'NW',
      position: Offset(10, 120),
      height: 45,
    ),
    const Furniture(
      name: 'doorway',
      direction: 'NE',
      position: Offset(110, 45),
      height: 60,
    ),
    Slot(
      id: 10,
      height: 50,
      visual: 'round_rug_outline',
      acceptables: const [
        Furniture(
          name: 'bathroom_rug_white',
          height: 80,
          position: Offset(125, 110),
        ),
        Furniture(
          name: 'bathroom_rug_red',
          height: 80,
          position: Offset(125, 110),
        ),
        Furniture(
          name: 'basic_rug',
          height: 90,
          position: Offset(120, 100),
        ),
      ],
      position: const Offset(130, 120),
    ),
    Slot(
      id: 11,
      height: 45,
      visual: 'outline_wall_NE',
      acceptables: const [
        Furniture(
          name: 'aquarium',
          direction: 'NE',
          height: 55,
        ),
      ],
      position: const Offset(70, 55),
    ),
    Slot(
      id: 12,
      height: 35,
      visual: 'outline',
      acceptables: const [
        Furniture(
          name: 'dog_statue',
          direction: 'SE',
          height: 40,
          position: Offset(200, 225),
        ),
      ],
      position: const Offset(200, 230),
    ),
  ],
);

Room washroom = const Room(
  name: 'washroom',
  width: 170,
  length: 170,
  height: 80,
  unlockOrder: 6,
  items: [],
);
