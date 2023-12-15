import 'package:flutter/material.dart';

import '../src.dart';

class MyDecorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Palette.tetiaryColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    Paint fillPaint = Paint()
      ..color = Palette.tetiaryColor
      ..style = PaintingStyle.fill;

    Path path = Path();

    // Starting point of the curve
    Offset startPoint = Offset(0, size.height / 3);

    // Control points
    Offset controlPoint1 = Offset(size.width / 4, 0);
    Offset controlPoint2 = Offset(size.width / 4 * 3, size.height);

    // Ending point of the curve
    Offset endPoint = Offset(size.width, size.height / 1.7);

    // Move the path to the starting point
    path.moveTo(startPoint.dy, startPoint.dx);

    // Draw the Bézier curve
    path.cubicTo(
      controlPoint1.dx,
      controlPoint1.dy,
      controlPoint2.dx,
      controlPoint2.dy,
      endPoint.dx,
      endPoint.dy,
    );

    // Draw the path onto the canvas
    canvas.drawPath(path, paint);

    Path fillPath = Path.from(path);
    fillPath.lineTo(size.width, 0); // Top-right corner
    fillPath.lineTo(0, 0); // Top-left corner
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
