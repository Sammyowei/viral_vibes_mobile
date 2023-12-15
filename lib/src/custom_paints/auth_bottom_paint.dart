import 'package:flutter/material.dart';

import '../src.dart';

class MyBottomDecor extends CustomPainter {
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Palette.tetiaryColor
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    Paint fillPaint = Paint()
      ..color = Palette.tetiaryColor // Change the color as needed
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(size.width * (-0.5), size.height);
    path.quadraticBezierTo(
        size.width * 0.5, size.height * (0), size.width * .4, size.height * 1);

    canvas.drawPath(path, paint);

    Path fillPath = Path.from(path);
    // fillPath.moveTo(size.width * (-0.1), size.height);
    // fillPath.quadraticBezierTo(size.width * 0.7, size.height * (-0.5),
    //     size.width * 0.6, size.height * 1);
    // fillPath.lineTo(size.width * 0.6, size.height);
    // fillPath.close(); // Close the path to complete the shape

    canvas.drawPath(fillPath, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
