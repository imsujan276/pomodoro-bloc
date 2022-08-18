import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/src/bloc/bloc.dart';
import 'package:pomodoro/src/constants/constants.dart';
import 'package:pomodoro/src/data/enum/enum.dart';

class StatusTextWidget extends StatelessWidget {
  const StatusTextWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PomodoroCubit, PomodoroState>(
      builder: (context, pState) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
          child: BlocBuilder<TaskCubit, TaskState>(
            builder: (context, state) {
              return Text(
                state.activeTask == null
                    ? pState.state == PomodoroEnum.pomodoro
                        ? 'Time to Focus!'
                        : 'Time for a break!'
                    : state.activeTask!.title,
                style: const TextStyle(
                  color: kWhiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
