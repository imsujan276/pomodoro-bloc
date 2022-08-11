import 'package:flutter/material.dart';
import 'package:pomodoro/src/constants/constants.dart';
import 'package:pomodoro/src/data/enum/enum.dart';

Color getColorForState(PomodoroEnum state) {
  return state == PomodoroEnum.pomodoro
      ? kPomodoroColor
      : state == PomodoroEnum.shortBreak
          ? kShortBreakColor
          : state == PomodoroEnum.longBreak
              ? kLongBreakColor
              : kPomodoroColor;
}
