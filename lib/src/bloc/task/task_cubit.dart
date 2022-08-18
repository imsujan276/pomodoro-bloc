import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/src/data/models/models.dart';
import 'package:pomodoro/src/utils/utils.dart';
import 'package:uuid/uuid.dart';
part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskState());

  void init() async {
    emit(state.copyWith(tasks: await sp.getTasks()));
  }

  Future<void> addTask({
    required String title,
    required String note,
    required int estimatedPomodoroNum,
    required int actualPomodoroNum,
  }) async {
    final task = Task(
      id: const Uuid().v4(),
      title: title.trim(),
      note: note.trim(),
      estimatedPomodoroNum: estimatedPomodoroNum,
      actualPomodoroNum: actualPomodoroNum,
    );
    final tasks = [...state.tasks, task];
    sp.saveTasks(tasks);
    emit(state.copyWith(tasks: tasks));
  }

  void updateTask({
    required String id,
    required String title,
    required String note,
    required int estimatedPomodoroNum,
    required int actualPomodoroNum,
  }) {
    final tasks = state.tasks;
    final index = tasks.indexWhere((e) => e.id == id);
    tasks[index]
      ..title = title
      ..note = note
      ..estimatedPomodoroNum = estimatedPomodoroNum
      ..actualPomodoroNum = actualPomodoroNum;
    sp.saveTasks(tasks);
    emit(state.copyWith(tasks: tasks));
  }

  void toggleTaskCompletion(Task task) {
    final tasks = state.tasks;
    final index = tasks.indexWhere((e) => e.id == task.id);
    tasks[index].isCompleted = !tasks[index].isCompleted;
    sp.saveTasks(tasks);
    emit(state.copyWith(tasks: tasks));
  }

  void selectTask(Task task) {
    emit(state.copyWith(activeTask: task));
  }

  void deleteCompletedTasks() {
    final nonCompletedTasks =
        state.tasks.where((task) => !task.isCompleted).toList();
    sp.saveTasks(nonCompletedTasks);
    emit(state.copyWith(tasks: nonCompletedTasks));
  }

  void deleteAllTasks() {
    sp.saveTasks([]);
    emit(state.copyWith(tasks: []));
  }

  void updateActualPomodoroCount() {
    final tasks = state.tasks;
    final activeTask = state.activeTask;
    if (activeTask != null) {
      final index = tasks.indexWhere((e) => e.id == activeTask.id);
      tasks[index].actualPomodoroNum = activeTask.actualPomodoroNum + 1;
      sp.saveTasks(tasks);
      emit(state.copyWith(tasks: tasks));
    }
  }
}
