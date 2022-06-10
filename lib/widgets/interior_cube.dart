import 'package:flutter/material.dart';
import 'dart:math' as math;

// TODO: Implement Rooms, which have id and assigned textures
class InteriorCube extends StatelessWidget {
  final double width;
  final double height;
  final double depth;
  final double rotateX;
  final double rotateY;

  const InteriorCube({
    Key? key,
    required this.width,
    required this.height,
    required this.depth,
    this.rotateX = 0.0,
    rotateY = 0.0,
  })  : rotateY = rotateY % (math.pi * 2),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> children;
    late final top = _buildSide(side: 0);
    late final right = _buildSide(side: 1);
    late final bottom = _buildSide(side: 2);
    late final left = _buildSide(side: 3);
    late final back = _buildSide(side: 4);
    late final front = _buildSide(side: 5);

    // Determine the layer order based on `rotateY`, divided into 45 degree
    // sections. Layer order is determined as if you are viewing from inside 
    // the cube; i.e., if the cube is tilted down towards the viewer, they 
    // would see the bottom instead of the top.
    if (rotateY < math.pi / 4) {
      children = [back, left];
    } else if (rotateY < math.pi / 2) {
      children = [back, left];
    } else if (rotateY < 3 * math.pi / 4) {
      children = [front, left];
    } else if (rotateY < math.pi) {
      children = [front, left];
    } else if (rotateY < 5 * math.pi / 4) {
      children = [front, right];
    } else if (rotateY < 3 * math.pi / 2) {
      children = [front, right];
    } else if (rotateY < 7 * math.pi / 4) {
      children = [right, back];
    } else {
      children = [right, back];
    }
    if (rotateX > 0.0) {
      // TODO: not perfect - does not consider perspective:
      children.add(bottom);
    } else {
      children.add(top);
    }

    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.0001)
        ..rotateX(rotateX)
        ..rotateY(rotateY),
      alignment: Alignment.center,
      child: Stack(children: children),
    );
  }

  /// Build sides: 0=top; 1="right"; 2=bottom; 3="left", 4=back, 5=front
  Widget _buildSide({required int side}) {
    final double translate;
    switch (side) {
      case 0: // top
        translate = height / -2;
        break;
      case 1: // starboard
        translate = width / 2;
        break;
      case 2: // bottom
        translate = height / 2;
        break;
      case 3: // port
        translate = width / -2;
        break;
      case 4: // back
        translate = depth / 2;
        break;
      case 5: // front
        translate = depth / -2;
        break;
      default:
        throw Exception('Invalid side: $side');
    }

    final bool topOrBottom = side == 0 || side == 2;
    final bool frontOrBack = side == 4 || side == 5;
    final Matrix4 transform;

    if (topOrBottom) {
      transform = Matrix4.identity()
        ..translate(0.0, translate, 0.0)
        ..rotateX(math.pi / 2);
    } else if (frontOrBack) {
      transform = Matrix4.identity()..translate(0.0, 0.0, translate);
      /* ..rotateZ(math.pi / 2); */
    } else {
      transform = Matrix4.identity()
        ..translate(translate, 0.0, 0.0)
        ..rotateY(math.pi / 2);
    }

    // TODO: Assign textures based on room id.
    final BoxDecoration dec = BoxDecoration(
      image: DecorationImage(
        image: topOrBottom
            ? const AssetImage('assets/board.png')
            : const AssetImage('assets/wall.jpg'),
        repeat: ImageRepeat.repeatX,
        fit: BoxFit.fill,
      ),
    );

    final face = Transform(
      transform: transform,
      alignment: Alignment.center,
      child: Center(
        child: Container(
          width: topOrBottom || frontOrBack ? width : depth,
          height: topOrBottom ? depth : height,
          decoration: dec,
          /* color: Colors.purple, */
        ),
      ),
    );

    return !frontOrBack
        ? Positioned.fill(
            child: face,
          )
        : face;
  }
}
