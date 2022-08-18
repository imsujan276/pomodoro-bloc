part of 'task_cubit.dart';


class TaskState {
  final Task? activeTask;
  final List<Task> tasks;

  TaskState({
    this.activeTask,
    this.tasks = const [],
  });

  TaskState copyWith({
    Task? activeTask,
    List<Task>? tasks,
  }) {
    return TaskState(
      activeTask: activeTask ?? this.activeTask,
      tasks: tasks ?? this.tasks,
    );
  }
}
