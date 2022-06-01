import 'package:flutter/material.dart';
import 'package:projectmercury/pages/store_page.dart';
import 'package:provider/provider.dart';

import '../models/store_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<List<PurchasedItem>>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Consumer<List<PurchasedItem>>(
        builder: (_, items, __) {
          return SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomPaint(
                  painter: IsometricHome(hexColor: '#bcbcbc'),
                ),
                Wrap(
                  children: [
                    for (PurchasedItem item in items)
                      Icon(
                        IconData(item.icon, fontFamily: 'MaterialIcons'),
                        size: 50,
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: SizedBox(
        width: 64,
        height: 64,
        child: FloatingActionButton(
          child: const Icon(Icons.storefront, size: 42),
          onPressed: () {
            showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              context: context,
              builder: (context) {
                return const StorePage();
              },
            );
          },
        ),
      ),
    );
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

String _textSubString(String text) {
  return text.substring(1, text.length);
}

// Colour adjustment function
// Taken from http://stackoverflow.com/questions/5560248
String shadeColor(String hexColor, percent) {
  var num = int.parse(_textSubString(hexColor), radix: 16),
      amountToDarken = (2.55 * percent).round(),
      R = (num >> 16) + amountToDarken,
      G = (num >> 8 & 0x00FF) + amountToDarken,
      B = (num & 0x0000FF) + amountToDarken;

  if (R > 255) {
    R = 255;
  } else if (R < 0) {
    R = 0;
  }
  if (G > 255) {
    G = 255;
  } else if (G < 0) {
    G = 0;
  }
  if (B > 255) {
    B = 255;
  } else if (B < 0) {
    B = 0;
  }
  return '#' +
      (0x1000000 + R * 0x10000 + G * 0x100 + B).toRadixString(16).substring(1);
}

void drawSurface(
    {required Canvas canvas,
    required String hexColor,
    required double x,
    required double y,
    required double wx,
    required double wy,
    required double h}) {
  final leftWall = Path()
    ..moveTo(x, y)
    ..lineTo(x, y + h * 1)
    ..lineTo(x - wx, y - wx * 0.5)
    ..lineTo(x - wx, y - h - wx * 0.5)
    ..close();
  final leftWallFillPaint = Paint()
    ..color = HexColor.fromHex(shadeColor(hexColor, -1))
    ..style = PaintingStyle.fill;
  final leftWallStrokePaint = Paint()
    ..color = HexColor.fromHex(hexColor)
    ..style = PaintingStyle.stroke;
  canvas.save();
  canvas.drawPath(leftWall, leftWallFillPaint);
  canvas.restore();
  canvas.save();
  canvas.drawPath(leftWall, leftWallStrokePaint);
  canvas.restore();

  final rightWall = Path()
    ..moveTo(x, y)
    ..lineTo(x, y + h * 1)
    ..lineTo(x + wy, y - wy * 0.5)
    ..lineTo(x + wy, y - h - wy * 0.5)
    ..close();

  final rightWallFillPaint = Paint()
    ..color = HexColor.fromHex(shadeColor(hexColor, 5))
    ..style = PaintingStyle.fill;
  final rightWallStrokePaint = Paint()
    ..color = HexColor.fromHex(shadeColor(hexColor, 50))
    ..style = PaintingStyle.stroke;
  canvas.save();
  canvas.drawPath(rightWall, rightWallFillPaint);
  canvas.restore();
  canvas.save();
  canvas.drawPath(rightWall, rightWallStrokePaint);
  canvas.restore();

  final floor = Path()
    ..moveTo(x, y - h)
    ..lineTo(x - wx, y - h - wx * 0.5)
    ..lineTo(x - wx + wy, y - h - (wx * 0.5 + wy * 0.5))
    ..lineTo(x + wy, y - h - wy * 0.5)
    ..close();

  final floorFillPaint = Paint()
    ..color = HexColor.fromHex(shadeColor(hexColor, -5))
    ..style = PaintingStyle.fill;
  final floorStrokePaint = Paint()
    ..color = HexColor.fromHex(shadeColor(hexColor, 60))
    ..style = PaintingStyle.stroke;
  canvas.save();
  canvas.drawPath(floor, floorFillPaint);
  canvas.restore();
  canvas.save();
  canvas.drawPath(floor, floorStrokePaint);
  canvas.restore();
}

class IsometricHome extends CustomPainter {
  final double leftDepth;
  final double rightDepth;
  final double y;
  final String hexColor;

  IsometricHome(
      {this.leftDepth = 150,
      this.rightDepth = 150,
      this.y = 100,
      required this.hexColor});

  @override
  void paint(Canvas canvas, Size size) {
    drawSurface(
      canvas: canvas,
      hexColor: hexColor,
      x: size.width / 2,
      y: size.height / 2,
      wx: leftDepth,
      wy: rightDepth,
      h: -150,
    );
    canvas.translate(size.width / 2, size.height / 2);
  }

  @override
  bool shouldRepaint(IsometricHome oldDelegate) => false;
}
