import 'package:flutter/foundation.dart';

enum PomodoroEnum { pomodoro, shortBreak, longBreak }

extension EnumEx on String {
  PomodoroEnum toTimerState() => PomodoroEnum.values.firstWhere(
        (d) => describeEnum(d) == toLowerCase(),
      );
}

enum Status { initial, success, error, loading }

extension StatusEx on Status {
  bool get isInitial => this == Status.initial;
  bool get isSuccess => this == Status.success;
  bool get isError => this == Status.error;
  bool get isLoading => this == Status.loading;
}
