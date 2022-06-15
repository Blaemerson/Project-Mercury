import 'package:flutter/material.dart';

class Furniture {
  final double width;
  final double height;
  final double positionX;
  final double positionY;
  final String type;
  String? variant;
  Furniture({
    Key? key,
    required this.width,
    required this.height,
    required this.positionX,
    required this.positionY,
    required this.type,
    this.variant,
  });

  void set(String variant) {
    this.variant;
  }

  Widget build(BuildContext context) {
    // show container boundaries
    bool _debugBox = false;
    // TODO: Different furniture image based on variant
    Image img = Image(image: AssetImage('assets/${type}.png'));

    return Positioned(
      width: width,
      height: height,
      left: positionX,
      bottom: positionY,
      child: variant != null
          ? Container(
              color: _debugBox
                  ? Color.fromARGB(67, 255, 7, 7)
                  : Colors.transparent,
              child: img,
            )
          : Container(),
    );
  }
}
