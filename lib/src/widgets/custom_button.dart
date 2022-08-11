import 'package:flutter/material.dart';
import 'package:pomodoro/src/constants/app_colors.dart';
import 'package:pomodoro/src/utils/helpers/size_config.dart' as size;

import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final double height;
  final double width;
  final double borderRadius;
  final Color textColor;
  final FontWeight fontWeight;
  final double fontSize;
  final VoidCallback? onPressed;

  const CustomButton(
      {Key? key,
      required this.text,
      this.color = kPrimary,
      this.height = 50,
      this.width = double.maxFinite,
      this.borderRadius = 8.0,
      this.textColor = Colors.white,
      this.fontWeight = FontWeight.normal,
      this.fontSize = 18,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height(height),
      width: size.width(width),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              size.radius(borderRadius),
            ),
          ),
        ),
        child: CustomText(
          text: text,
          fontSize: fontSize,
          color: textColor,
          fontWeight: fontWeight,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
