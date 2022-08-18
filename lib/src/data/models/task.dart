// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Task {
  String id;
  String title;
  int estimatedPomodoroNum;
  int actualPomodoroNum;
  String note;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    this.estimatedPomodoroNum = 1,
    this.actualPomodoroNum = 0,
    this.note = "",
    this.isCompleted = false,
  });

  Task copyWith({
    String? id,
    String? title,
    int? estimatedPomodoroNum,
    int? actualPomodoroNum,
    String? note,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      estimatedPomodoroNum: estimatedPomodoroNum ?? this.estimatedPomodoroNum,
      actualPomodoroNum: actualPomodoroNum ?? this.actualPomodoroNum,
      note: note ?? this.note,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'estimatedPomodoroNum': estimatedPomodoroNum,
      'actualPomodoroNum': actualPomodoroNum,
      'note': note,
      'isCompleted': isCompleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as String,
      title: map['title'] as String,
      estimatedPomodoroNum: map['estimatedPomodoroNum'] as int,
      actualPomodoroNum: map['actualPomodoroNum'] as int,
      note: map['note'] as String,
      isCompleted: map['isCompleted'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source) as Map<String, dynamic>);
}
