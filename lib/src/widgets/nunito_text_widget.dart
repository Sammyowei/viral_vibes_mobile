import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget nunitoTextWidget(
  String text, {
  double fontSize = 18,
  FontWeight fontWeight = FontWeight.normal,
  Color color = Colors.black87,
  TextAlign textAlign = TextAlign.left,
}) {
  return Text(
    text,
    textAlign: textAlign,
    style: GoogleFonts.nunitoSans(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    ),
  );
}
