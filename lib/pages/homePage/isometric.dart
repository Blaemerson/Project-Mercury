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
        ..rotateX((90 - 35.264) * math.pi / 180)
        ..rotateZ(-math.pi / 4),
      child: child,
    );
  }
}

/// Creates an actor for viewing within an IsometricView widget.
class Actor extends StatelessWidget {
  final Widget child;
  final Alignment alignment;

  const Actor({Key? key, required this.child, this.alignment = Alignment.center}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: alignment,
      transform: Matrix4.identity()
        ..rotateZ(math.pi / 4)
        ..rotateX(-(90 - 35.264) * math.pi / 180),
      /* ..rotateX(-math.pi / 2) */
      /* ..rotateY(-45 * math.pi / 180) */
      /* ..rotateX(-35.264 * math.pi / 180), */
      child: child,
    );
  }
}
