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

  Future<void> saveTasks(List<Task> tasks) async {
    List<String> _taskStrings = [];
    for (var task in tasks) {
      _taskStrings.add(task.toJson());
    }
    sp.setStringList("tasks", _taskStrings);
  }

  Future<List<Task>> getTasks() async {
    List<Task> tasks = [];
    List<String> _taskStrings = sp.getStringList("tasks") ?? [];
    for (var taskString in _taskStrings) {
      tasks.add(Task.fromJson(taskString));
    }
    return tasks;
  }
}
