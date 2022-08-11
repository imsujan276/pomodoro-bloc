import 'package:flutter/material.dart';
import 'package:pomodoro/src/constants/constants.dart';
import 'package:pomodoro/src/widgets/widgets.dart';

void showSnackbar(BuildContext context, String error, {bool isError = false}) {
  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(
      SnackBar(
        content: CustomText(text: error, color: Colors.white),
        backgroundColor: isError ? kRed : kBlackColor,
        duration: const Duration(seconds: 3),
      ),
    );
}
