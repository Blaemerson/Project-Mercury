import 'package:flutter/material.dart';

class Furniture extends StatelessWidget {
  final int variant;
  final String type;
  const Furniture({Key? key, required this.type, required this.variant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    // TODO: Different furniture image based on variant
    DecorationImage img = DecorationImage(
      image: AssetImage('assets/$type.png'),
      /* fit: BoxFit.fitWidth, */
    );
    return Center(
      child: Container(
        alignment: Alignment.center,
        /* width: 100, */
        /* height: 100, */
        decoration: BoxDecoration(
          /* border: Border.all(color: Colors.black), */
          borderRadius: BorderRadius.circular(16),
          /* color: Colors.white, */
          image: img,
        ),
      ),
    );
  }
}
