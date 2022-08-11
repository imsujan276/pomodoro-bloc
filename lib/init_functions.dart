import 'package:flutter/services.dart';
import 'package:pomodoro/src/services/local_notification/local_notification_service.dart';
import 'package:pomodoro/src/utils/utils.dart';

Future<void> initFunctions() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
    ),
  );
  await SpHelper.init();
  await LocalNotificationService().initNotification();
}
