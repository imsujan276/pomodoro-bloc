part of 'pomodoro_cubit.dart';

class PomodoroState extends Equatable {
  final PomodoroEnum state;
  final int time;

  const PomodoroState({
    this.state = PomodoroEnum.pomodoro,
    this.time = 0,
  });

  @override
  List<Object> get props => [state, time];

  PomodoroState copyWith({
    PomodoroEnum? state,
    int? time,
  }) {
    return PomodoroState(
      state: state ?? this.state,
      time: time ?? this.time,
    );
  }
}
