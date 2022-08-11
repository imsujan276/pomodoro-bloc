part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class SettingsInitEvent extends SettingsEvent {}

class SettingsUpdateEvent extends SettingsEvent {
  final SettingModel settingModel;

  SettingsUpdateEvent({required this.settingModel});
}
