import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pomodoro/src/data/enum/enum.dart';
import 'package:pomodoro/src/data/models/models.dart';
import 'package:pomodoro/src/utils/utils.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState()) {
    on<SettingsInitEvent>(_onSettingInitEvent);
    on<SettingsUpdateEvent>(_onSettingsUpdateEvent);
  }

  Future<void> _onSettingInitEvent(
    SettingsInitEvent event,
    Emitter<SettingsState> emit,
  ) async {
    final storedSettings = await sp.getSettings();
    if (storedSettings != null) {
      emit(state.copyWith(settings: storedSettings));
    }
  }

  Future<void> _onSettingsUpdateEvent(
    SettingsUpdateEvent event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      emit(state.copyWith(status: Status.loading));
      // await Future.delayed(const Duration(seconds: 2));
      await sp.saveSettings(event.settingModel);
      emit(state.copyWith(
        settings: event.settingModel,
        status: Status.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: Status.error,
      ));
    }
  }
}
