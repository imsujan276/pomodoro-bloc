// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

const SettingModel settingModelInitial = SettingModel(
  timerPomodoro: 25 * 60,
  timerShortBreak: 5 * 60,
  timerLongBreak: 15 * 60,
  longBreakInterval: 4,
  autoShortBreaks: false,
  autoLongBreak: false,
);

class SettingModel {
  final int timerPomodoro;
  final int timerShortBreak;
  final int timerLongBreak;
  final int longBreakInterval;
  final bool autoShortBreaks;
  final bool autoLongBreak;

  const SettingModel({
    required this.timerPomodoro,
    required this.timerShortBreak,
    required this.timerLongBreak,
    required this.longBreakInterval,
    required this.autoShortBreaks,
    required this.autoLongBreak,
  });

  SettingModel copyWith({
    int? timerPomodoro,
    int? timerShortBreak,
    int? timerLongBreak,
    int? longBreakInterval,
    bool? autoShortBreaks,
    bool? autoLongBreak,
  }) {
    return SettingModel(
      timerPomodoro: timerPomodoro ?? this.timerPomodoro,
      timerShortBreak: timerShortBreak ?? this.timerShortBreak,
      timerLongBreak: timerLongBreak ?? this.timerLongBreak,
      longBreakInterval: longBreakInterval ?? this.longBreakInterval,
      autoShortBreaks: autoShortBreaks ?? this.autoShortBreaks,
      autoLongBreak: autoLongBreak ?? this.autoLongBreak,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'timerPomodoro': timerPomodoro,
      'timerShortBreak': timerShortBreak,
      'timerLongBreak': timerLongBreak,
      'longBreakInterval': longBreakInterval,
      'autoShortBreaks': autoShortBreaks,
      'autoLongBreak': autoLongBreak,
    };
  }

  factory SettingModel.fromMap(Map<String, dynamic> map) {
    return SettingModel(
      timerPomodoro: map['timerPomodoro'] as int,
      timerShortBreak: map['timerShortBreak'] as int,
      timerLongBreak: map['timerLongBreak'] as int,
      longBreakInterval: map['longBreakInterval'] as int,
      autoShortBreaks: map['autoShortBreaks'] as bool,
      autoLongBreak: map['autoLongBreak'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory SettingModel.fromJson(String source) =>
      SettingModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SettingModel(timerPomodoro: $timerPomodoro, timerShortBreak: $timerShortBreak, timerLongBreak: $timerLongBreak, longBreakInterval: $longBreakInterval, autoShortBreaks: $autoShortBreaks, autoLongBreak: $autoLongBreak)';
  }

  @override
  bool operator ==(covariant SettingModel other) {
    if (identical(this, other)) return true;

    return other.timerPomodoro == timerPomodoro &&
        other.timerShortBreak == timerShortBreak &&
        other.timerLongBreak == timerLongBreak &&
        other.longBreakInterval == longBreakInterval &&
        other.autoShortBreaks == autoShortBreaks &&
        other.autoLongBreak == autoLongBreak;
  }

  @override
  int get hashCode {
    return timerPomodoro.hashCode ^
        timerShortBreak.hashCode ^
        timerLongBreak.hashCode ^
        longBreakInterval.hashCode ^
        autoShortBreaks.hashCode ^
        autoLongBreak.hashCode;
  }
}
