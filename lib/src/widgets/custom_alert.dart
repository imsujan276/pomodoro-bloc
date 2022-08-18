import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pomodoro/src/widgets/widgets.dart';

import '../constants/constants.dart';
import '../utils/helpers/helpers.dart';

Future<bool> customAlert({
  required BuildContext context,
  title = "Are you sure?",
  required String msg,
  Color btnColor = kPrimary,
}) async {
  return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Center(
              child: CustomText(
            text: "Are you sure?",
            fontWeight: FontWeight.bold,
          )),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                text: msg,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: "Cancel",
                    color: kLightGrey,
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                  ),
                ),
                Gap(width(20)),
                Expanded(
                  child: CustomButton(
                    text: "OK",
                    color: btnColor,
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      });
}
