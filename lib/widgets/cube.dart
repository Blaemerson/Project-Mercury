import 'package:flutter/material.dart';
import 'dart:math' as math;

// TODO: Implement Rooms, which have id and assigned textures
class Cube extends StatelessWidget {
  final double width;
  final double height;
  final double depth;
  final double rotateX;
  final double rotateY;
  final double fov;
  final bool isInterior;

  const Cube({
    Key? key,
    required this.width,
    required this.height,
    required this.depth,
    this.rotateX = 0.0,
    this.isInterior = false,
    rotateY = 0.0,
    this.fov = 0.0,
  })  : rotateY = rotateY % (math.pi * 2),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> children;
    late final bottom = _buildSide(side: 0);
    late final top = _buildSide(side: 1);
    late final right = _buildSide(side: 2);
    late final left = _buildSide(side: 3);
    late final back = _buildSide(side: 4);
    late final front = _buildSide(side: 5);

    // field of view
    double xFov = width / 200 * fov;
    double yFov = height / 200 * fov;
    double zFov = depth / 200 * fov;

    // Determine the layer order based on `rotateY`, divided into 45 degree
    // sections. Layer order is determined as if you are viewing from inside
    // the cube; i.e., if the cube is tilted down towards the viewer, they
    // would see the bottom instead of the top.

    // Still not perfect for diagonal view
    if (rotateY < xFov) {
      children = [left, back, right];
    } else if (rotateY < math.pi / 2 - yFov) {
      children = [left, back];
    } else if (rotateY < math.pi / 2 + yFov) {
      children = [front, left, back];
    } else if (rotateY < math.pi - xFov) {
      children = [front, left];
    } else if (rotateY < math.pi + xFov) {
      children = [right, front, left];
    } else if (rotateY < 3 * math.pi / 2 - yFov) {
      children = [right, front];
    } else if (rotateY < 3 * math.pi / 2 + yFov) {
      children = [back, right, front];
    } else if (rotateY < 2 * math.pi - xFov) {
      children = [back, right];
    } else {
      children = [left, back, right];
    }

    if (rotateX < -zFov) {
      children.add(top);
    } else if (rotateX < zFov && rotateX > -zFov) {
      children.addAll([bottom, top]);
    } else if (rotateX <= math.pi / 2) {
      children.add(bottom);
    }

    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, fov / 100)
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
      case 0: // bottom
        translate = height / 2;
        break;
      case 1: // top
        translate = height / -2;
        break;
      case 2: // right
        translate = width / 2;
        break;
      case 3: // left
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

    final bool topOrBottom = side == 0 || side == 1;
    final bool frontOrBack = side == 4 || side == 5;
    final Matrix4 transform;

    if (topOrBottom) {
      transform = Matrix4.identity()
        ..translate(0.0, translate, 0.0)
        ..rotateX(math.pi / 2);
    } else if (frontOrBack) {
      transform = Matrix4.identity()..translate(0.0, 0.0, translate);
    } else {
      transform = Matrix4.identity()
        ..translate(translate, 0.0, 0.0)
        ..rotateY(math.pi / 2);
    }

    final BoxDecoration dec = BoxDecoration(
      border: Border.all(color: Colors.brown, width: 0.5),
      color: const Color.fromARGB(70, 255, 255, 255),
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

    return face;
  }
}
