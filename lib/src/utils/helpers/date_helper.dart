import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

String formattingTimeOfDay(
  TimeOfDay timeOfDay, {
  bool fullDate = false,
  DateTime? dateTime,
}) {
  final now = dateTime ?? DateTime.now();
  final date = DateTime(
    now.year,
    now.month,
    now.day,
    timeOfDay.hour,
    timeOfDay.minute,
  );
  final timeFormat = DateFormat.jm();
  final dateFormat = DateFormat("yyyy-MM-dd hh:mm a");
  return fullDate ? dateFormat.format(date) : timeFormat.format(date);
}

String pareseDateTime(
  DateTime dateTime, {
  bool dateOnly = false,
  bool timeOnly = false,
}) {
  late DateFormat dateFormat;
  if (dateOnly) {
    dateFormat = DateFormat("yyyy-MM-dd");
  } else if (timeOnly) {
    dateFormat = DateFormat("hh:mm a");
  } else {
    dateFormat = DateFormat("yyyy-MM-dd hh:mm a");
  }
  return dateFormat.format(dateTime);
}

tz.TZDateTime convertStringTimeDateToDateTime(String date, String time) {
  DateTime _date = DateFormat.yMd().parse(date);
  DateTime _time = DateFormat.jm().parse(time);
  tz.TZDateTime scheduleDate = tz.TZDateTime(
    tz.local,
    _date.year,
    _date.month,
    _date.day,
    _time.hour,
    _time.minute,
  );
  return scheduleDate;
}

bool isToday(DateTime date) {
  final today = DateTime.now();
  return date.year == today.year &&
      date.month == today.month &&
      date.day == today.day;
}

bool isSameDate(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}
