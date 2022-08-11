import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pomodoro/src/bloc/bloc.dart';
import 'package:pomodoro/src/constants/constants.dart';
import 'package:pomodoro/src/data/enum/enum.dart';
import 'package:pomodoro/src/services/audio_player/audio_player_service.dart';
import 'package:pomodoro/src/services/local_notification/local_notification_service.dart';

part 'pomodoro_state.dart';

class PomodoroCubit extends Cubit<PomodoroState> {
  final SettingsBloc settingsBloc;
  final TimerBloc timerBloc;
  final AudioPlayerService audioPlayerService;
  final LocalNotificationService localNotificationService;

  int shortBreakCount = 0;

  PomodoroCubit({
    required this.settingsBloc,
    required this.timerBloc,
    required this.audioPlayerService,
    required this.localNotificationService,
  }) : super(const PomodoroState());

  init() {
    Future.delayed(const Duration(milliseconds: 500), () {
      selectState(PomodoroEnum.pomodoro);
      shortBreakCount = 0;
    });
  }

  selectState(PomodoroEnum s) {
    final int time = getTimeFromState(s);
    updateState(s, time);
    timerBloc.add(TimerInit(time));
  }

  updateState(PomodoroEnum st, int time) {
    emit(state.copyWith(state: st, time: time));
  }

  int getTimeFromState(PomodoroEnum state) {
    switch (state) {
      case PomodoroEnum.pomodoro:
        return settingsBloc.state.settings.timerPomodoro;
      case PomodoroEnum.shortBreak:
        return settingsBloc.state.settings.timerShortBreak;
      case PomodoroEnum.longBreak:
        return settingsBloc.state.settings.timerLongBreak;
      default:
        return 0;
    }
  }

  PomodoroEnum getNextState() {
    final PomodoroEnum _state = state.state;
    switch (_state) {
      case PomodoroEnum.pomodoro:
        return PomodoroEnum.shortBreak;
      case PomodoroEnum.shortBreak:
        return PomodoroEnum.longBreak;
      case PomodoroEnum.longBreak:
        return PomodoroEnum.pomodoro;
      default:
        return PomodoroEnum.pomodoro;
    }
  }

  void onTimerComplete() {
    /// play the notification sound
    audioPlayerService.play();

    final PomodoroEnum _nextState = getNextState();
    final int _nextStateTime = getTimeFromState(_nextState);

    switch (state.state) {
      case PomodoroEnum.pomodoro:
        localNotificationService.showPushNotification(
          title: "$kAppName Update",
          body: "Pomodoro completed",
        );
        updateState(_nextState, _nextStateTime);
        timerBloc.add(TimerInit(_nextStateTime));
        if (settingsBloc.state.settings.autoShortBreaks) {
          timerBloc.add(TimerStarted(_nextStateTime));
        }
        break;

      case PomodoroEnum.longBreak:
        localNotificationService.showPushNotification(
          title: "$kAppName Update",
          body: "Long Break completed",
        );
        updateState(_nextState, _nextStateTime);
        timerBloc.add(TimerInit(_nextStateTime));
        if (settingsBloc.state.settings.autoLongBreak) {
          timerBloc.add(TimerStarted(_nextStateTime));
        }
        break;

      case PomodoroEnum.shortBreak:
        localNotificationService.showPushNotification(
          title: "$kAppName Update",
          body: "Short Break completed",
        );
        shortBreakCount += 1;
        if (shortBreakCount % settingsBloc.state.settings.longBreakInterval ==
            0) {
          // go to long break state
          updateState(_nextState, _nextStateTime);
          if (settingsBloc.state.settings.autoLongBreak) {
            timerBloc.add(TimerStarted(_nextStateTime));
          } else {
            timerBloc.add(TimerInit(_nextStateTime));
          }
        } else {
          // go to pomodoro state
          updateState(
            PomodoroEnum.pomodoro,
            getTimeFromState(PomodoroEnum.pomodoro),
          );
          if (settingsBloc.state.settings.autoShortBreaks) {
            timerBloc.add(TimerStarted(state.time));
          } else {
            timerBloc.add(TimerInit(_nextStateTime));
          }
        }
        break;
      default:
        break;
    }
  }
}
