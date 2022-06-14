import 'package:flutter/material.dart';

import 'package:projectmercury/widgets/furniture.dart';
import 'package:projectmercury/widgets/room.dart';

class LivingRoom extends StatefulWidget {
  const LivingRoom({Key? key}) : super(key: key);

  @override
  State<LivingRoom> createState() => _LivingRoomState();
}

// TODO: Layout undecided
class _LivingRoomState extends State<LivingRoom> {
  @override
  Widget build(BuildContext context) {
    return const Room(
      width: 250,
      depth: 300,
      items: [
        Furniture(
          width: 100,
          height: 100,
          positionX: 170,
          positionY: 20,
          type: 'table',
          variant: '',
        ),
        Furniture(
          width: 150,
          height: 150,
          positionX: 0,
          positionY: 90,
          type: 'fireplace',
          variant: '',
        ),
        Furniture(
          width: 100,
          height: 100,
          positionX: 110,
          positionY: 140,
          type: 'chair',
          variant: '',
        ),
      ],
    );
//     Stack(
//       children: const [
//         Cube(
//           width: 250,
//           height: 170,
//           depth: 300,
//           rotateY: 45 * math.pi / 180,
//           rotateX: 35.264 * math.pi / 180,
//           fov: 0 * math.pi / 180,
//           floorTexture: AssetImage('assets/wood_floor.jpg'),
//           wallTexture: AssetImage('assets/floral_wall.jpg'),
//         ),
//         Positioned(
//           bottom: 20,
//           right: 30,
//           child: SizedBox(
//             height: 100,
//             width: 100,
//             child: Furniture(type: "table", variant: 0),
//           ),
//         ),
//         Positioned(
//           top: 60,
//           child: SizedBox(
//             height: 150,
//             width: 150,
//             child: Furniture(type: "fireplace", variant: 0),
//           ),
//         ),
//         Positioned(
//           top: 60,
//           left: 110,
//           child: SizedBox(
//             height: 100,
//             width: 100,
//             child: Furniture(type: "chair", variant: 0),
//           ),
//         ),
//       ],
//     );
//   }
// }
  }
}
