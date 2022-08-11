// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  final SettingModel settings;
  final Status status;

  const SettingsState({
    this.status = Status.initial,
    SettingModel? settings,
  }) : settings = settings ?? settingModelInitial;

  @override
  List<Object?> get props => [status, settings];

  SettingsState copyWith({
    SettingModel? settings,
    Status? status,
  }) {
    return SettingsState(
      settings: settings ?? this.settings,
      status: status ?? this.status,
    );
  }
}
