import 'package:flutter/material.dart';
import 'package:projectmercury/pages/store_page.dart';
import 'package:projectmercury/widgets/cube.dart';
import 'dart:math' as math;

import 'package:projectmercury/widgets/furniture.dart';

class LivingRoom extends StatefulWidget {
  const LivingRoom({Key? key}) : super(key: key);

  @override
  State<LivingRoom> createState() => _LivingRoomState();
}

// TODO: Layout undecided
class _LivingRoomState extends State<LivingRoom> {
  Widget? _chair = Container(
    alignment: Alignment.center,
    width: 90,
    height: 90,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(16),
      color: Colors.white,
    ),
    child: const Text(
      "Buy Chair",
      textAlign: TextAlign.center,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      height: 400,
      child: Stack(
        children: [
          const Center(
            // TODO: either finalize viewing angle & FOV or allow users to rotate the view like before.
            // If angle is fixed; rendering a who cube may be unnecessary.
            child: Cube(
              width: 500,
              height: 300,
              depth: 310,
              rotateY: 0 * math.pi / 180,
              rotateX: 20 * math.pi / 180,
              fov: 15 * math.pi / 180,
              isInterior: true,
            ),
          ),
          const Positioned(
            left: 120,
            bottom: 40,
            child: Furniture(type: "table", variant: 0),
          ),
          Positioned(
            left: 30,
            bottom: 50,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    context: context,
                    builder: (context) {
                      return const SizedBox(
                        height: 232,
                        child: StorePage(),
                      );
                    },
                  );
                  // TODO: Wait until item purchased to place item.
                  setState(() {
                    _chair = const Furniture(type: "chair", variant: 0);
                  });
                },
                child: _chair,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
