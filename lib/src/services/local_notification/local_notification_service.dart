import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:pomodoro/src/constants/app_colors.dart';
import 'package:pomodoro/src/constants/app_constants.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  initNotification() async {
    _configureLocalTimeZone();
    const AndroidInitializationSettings initAndroidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initAndroidSettings);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<NotificationDetails> _notificationDetails() async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      'pomoChan',
      kAppName,
      groupKey: 'com.nerdplatoon.pomodoro',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      color: kPrimary,
      setAsGroupSummary: true,
      enableLights: true,
      // fullScreenIntent: true,
    );

    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    return platformChannelSpecifics;
  }

  showPushNotification({
    required String title,
    required String body,
  }) async {
    try {
      final int id = Random().nextInt(99999);
      final platformChannelSpecifics = await _notificationDetails();
      await _flutterLocalNotificationsPlugin.show(
        id,
        title,
        body,
        platformChannelSpecifics,
        payload: '$id',
      );
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timezone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timezone));
  }
}
