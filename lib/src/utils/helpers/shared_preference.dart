import 'package:pomodoro/src/data/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sp = SpHelper();

class SpHelper {
  static late SharedPreferences sp;

  static init() async => sp = await SharedPreferences.getInstance();

  Future<void> saveSettings(SettingModel setting) async {
    sp.setString("settings", setting.toJson());
  }

  Future<SettingModel?> getSettings() async {
    String? _settingString = sp.getString("settings");
    return _settingString == null
        ? null
        : SettingModel.fromJson(_settingString);
  }
}
