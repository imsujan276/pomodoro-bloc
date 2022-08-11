import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pomodoro/src/data/models/models.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker;

  /// to listen to the ticker stream
  StreamSubscription<int>? _tickerSubscription;

  /// holds the duration on initialization
  late int _duration;

  TimerBloc({
    required Ticker ticker,
  })  : _ticker = ticker,
        super(const TimerInitial(0)) {
    on<TimerInit>(_onTimerInit);
    on<TimerStarted>(_onStarted);
    on<TimerTicked>(_onTicked);
    on<TimerPaused>(_onPaused);
    on<TimerResumed>(_onResumed);
    on<TimerReset>(_onReset);
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onTimerInit(TimerInit event, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();
    _duration = event.duration;
    emit(TimerInitial(event.duration));
  }

  void _onStarted(TimerStarted event, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();
    emit(TimerRunInProgress(event.duration));
    _tickerSubscription = _ticker
        .tick(ticks: event.duration)
        .listen((duration) => add(TimerTicked(duration)));
  }

  void _onTicked(TimerTicked event, Emitter<TimerState> emit) {
    emit(event.duration > 0
        ? TimerRunInProgress(event.duration)
        : const TimerRunComplete());
  }

  void _onPaused(TimerPaused event, Emitter<TimerState> emit) {
    _tickerSubscription?.pause();
    emit(TimerRunPause(state.duration));
  }

  void _onResumed(TimerResumed event, Emitter<TimerState> emit) {
    _tickerSubscription?.resume();
    emit(TimerRunInProgress(state.duration));
  }

  void _onReset(TimerReset event, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();
    emit(TimerInitial(_duration));
  }
}
