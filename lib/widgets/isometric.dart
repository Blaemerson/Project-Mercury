import 'package:flutter/material.dart';
import 'dart:math' as math;

// 35.264 <- true isometric view angle
// 30 <- most commonly used isometric view angle

/// Creates an isometric view of a widget.
class IsometricView extends StatelessWidget {
  final Widget child;

  const IsometricView({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..rotateX(35.264 * math.pi / 180)
        ..rotateY(45 * math.pi / 180)
        ..rotateX(math.pi / 2),
      child: child,
    );
  }
}

/// Creates an actor for viewing within an IsometricView widget.
class Actor extends StatelessWidget {
  final Widget child;

  const Actor({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..rotateX(-math.pi / 2)
        ..rotateY(-45 * math.pi / 180)
        ..rotateX(-35.264 * math.pi / 180),
      child: child,
    );
  }
}
