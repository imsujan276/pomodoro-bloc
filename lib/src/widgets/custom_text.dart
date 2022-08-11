import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pomodoro/src/constants/app_constants.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final bool isTitle;
  final FontWeight fontWeight;
  final Color color;
  final int? maxLines;
  final TextOverflow overflow;
  final TextAlign textAlign;
  final double? letterSpacing;
  final bool isDone;
  final double? lineHeight;

  const CustomText({
    Key? key,
    required this.text,
    this.fontSize,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.black,
    this.maxLines,
    this.overflow = TextOverflow.visible,
    this.textAlign = TextAlign.left,
    this.letterSpacing,
    this.isTitle = false,
    this.isDone = false,
    this.lineHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      style: GoogleFonts.getFont(isTitle ? 'Poppins' : 'Roboto',
          fontSize: fontSize ?? kDefaultFontSize,
          fontWeight: fontWeight,
          color: color,
          letterSpacing: letterSpacing,
          textStyle: TextStyle(
            decoration: isDone ? TextDecoration.lineThrough : null,
            height: lineHeight,
          )),
    );
  }
}
