import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pomodoro/src/bloc/bloc.dart';
import 'package:pomodoro/src/constants/constants.dart';
import 'package:pomodoro/src/data/models/models.dart';
import 'package:pomodoro/src/utils/utils.dart';
import 'package:pomodoro/src/widgets/widgets.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(kDefaultMargin),
      child: Column(
        children: const [
          _TasksHeader(),
          Gap(10),
          _TasksList(),
        ],
      ),
    );
  }
}

class _TasksHeader extends StatelessWidget {
  const _TasksHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: kDefaultPadding * 0.75),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: kWhiteColor, width: 2)),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              "Tasks",
              style: TextStyle(
                  color: kWhiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
          PopupMenuButton(
            child: Container(
              padding: EdgeInsets.all(kDefaultPadding * 0.25),
              decoration: BoxDecoration(
                  color: kTransparentColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radius(5))),
              child: const Icon(Icons.more_vert, color: kWhiteColor),
            ),
            itemBuilder: (context) {
              return [
                _popupMenuItem("Delete Completed Tasks", 1),
                _popupMenuItem("Delete All Tasks", 2),
              ];
            },
            onSelected: (selectedValue) {
              switch (selectedValue) {
                case 1:
                  context.read<TaskCubit>().deleteCompletedTasks();
                  break;
                case 2:
                  context.read<TaskCubit>().deleteAllTasks();
                  break;
                default:
                  break;
              }
            },
          ),
        ],
      ),
    );
  }

  PopupMenuItem _popupMenuItem(String text, int value) {
    return PopupMenuItem(
      child: Text(
        text,
        style: const TextStyle(fontSize: 14),
      ),
      value: value,
    );
  }
}

class _TasksList extends StatelessWidget {
  const _TasksList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        return Column(
          children: [
            ...state.tasks
                .map((task) => _taskItem(task, context, state.activeTask))
                .toList(),
          ],
        );
      },
    );
  }

  Widget _taskItem(Task task, BuildContext context, Task? activeTask) {
    return GestureDetector(
      onTap: () {
        context.read<TaskCubit>().selectTask(task);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
        margin: EdgeInsets.only(bottom: kDefaultPadding * 0.75),
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(radius(10)),
          color: kWhiteColor,
          border: activeTask != null && activeTask.id == task.id
              ? const Border(left: BorderSide(width: 5))
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    context.read<TaskCubit>().toggleTaskCompletion(task);
                  },
                  icon: Icon(
                    Icons.check_box_rounded,
                    color: task.isCompleted ? kRed : kGrey,
                  ),
                ),
                Gap(width(5)),
                Expanded(
                  child: CustomText(
                    text: task.title,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: task.isCompleted ? kGrey : kBlackColor,
                    isDone: task.isCompleted,
                  ),
                ),
                Gap(width(5)),
                Text.rich(
                  TextSpan(
                    text: "${task.actualPomodoroNum}",
                    style: const TextStyle(
                      fontSize: 18,
                      color: kGrey,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: "/${task.estimatedPomodoroNum}",
                        style: const TextStyle(
                          fontSize: 15,
                          color: kGrey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(child: TaskForm(task: task));
                        });
                  },
                  icon: const Icon(Icons.edit_note_sharp, color: kGrey),
                ),
              ],
            ),
            if (task.note.isNotEmpty)
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: kDefaultMargin,
                  vertical: kDefaultPadding / 3,
                ),
                padding: EdgeInsets.all(kDefaultPadding),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius(10)),
                  color: kYellow.withOpacity(0.2),
                ),
                child: CustomText(
                  text: task.note,
                  fontSize: 15,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
