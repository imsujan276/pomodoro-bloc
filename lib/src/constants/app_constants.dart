import 'package:flutter/material.dart';
import 'package:pomodoro/src/data/models/models.dart';
import 'package:pomodoro/src/utils/helpers/helpers.dart';

/// Global context
GlobalKey<NavigatorState> kNavigatorKey = GlobalKey<NavigatorState>();

const String kAppName = "Pomo Timer";

double kDefaultPadding = height(16);
double kDefaultMargin = height(16);
double kDefaultFontSize = 18;

/// names of the sound in assets/sounds folder
List<String> alarmSoundNames = ['1', '2', '3', '4', '5'];

/// default settings
const SettingModel settingModelInitial = SettingModel(
  timerPomodoro: 25 * 60,
  timerShortBreak: 5 * 60,
  timerLongBreak: 15 * 60,
  longBreakInterval: 4,
  autoShortBreaks: false,
  autoLongBreak: false,
  alarmSound: "1",
);
