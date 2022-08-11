part of 'timer_bloc.dart';

abstract class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object> get props => [];
}

class TimerInit extends TimerEvent {
  final int duration;
  const TimerInit(this.duration);

  @override
  List<Object> get props => [duration];
}

class TimerStarted extends TimerEvent {
  final int duration;
  const TimerStarted(this.duration);

  @override
  List<Object> get props => [duration];
}

class TimerPaused extends TimerEvent {
  const TimerPaused();

  @override
  List<Object> get props => [];
}

class TimerResumed extends TimerEvent {
  final int duration;
  const TimerResumed(this.duration);

  @override
  List<Object> get props => [duration];
}

class TimerReset extends TimerEvent {
  const TimerReset();
  @override
  List<Object> get props => [];
}

class TimerTicked extends TimerEvent {
  final int duration;
  const TimerTicked(this.duration);

  @override
  List<Object> get props => [duration];
}
