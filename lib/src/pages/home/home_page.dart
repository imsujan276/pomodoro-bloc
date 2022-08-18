import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:pomodoro/src/bloc/bloc.dart';
import 'package:pomodoro/src/constants/constants.dart';
import 'package:pomodoro/src/data/enum/enum.dart';
import 'package:pomodoro/src/pages/home/widgets/task_widget.dart';
import 'package:pomodoro/src/pages/settings/settings_page.dart';
import 'package:pomodoro/src/utils/utils.dart';
import 'package:pomodoro/src/widgets/task_form.dart';

import 'widgets/status_text_widget.dart';
import 'widgets/timer_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        MoveToBackground.moveTaskToBack();
        return false;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text(kAppName),
          actions: [
            IconButton(
              onPressed: () async {
                final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsPage()));
                if (result != null) {
                  // on settings update, restart the state
                  context.read<PomodoroCubit>()
                    ..selectState(PomodoroEnum.pomodoro)
                    ..shortBreakCount = 0;
                }
              },
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
        body: BlocBuilder<PomodoroCubit, PomodoroState>(
          builder: (context, state) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              height: double.maxFinite,
              decoration: BoxDecoration(
                color: getColorForState(state.state),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Gap(80),
                    TimerWidget(),
                    StatusTextWidget(),
                    TaskWidget(),
                  ],
                ),
              ),
            );
          },
        ),
        floatingActionButton: BlocBuilder<PomodoroCubit, PomodoroState>(
          builder: (context, state) {
            return FloatingActionButton.extended(
              backgroundColor: getColorForState(state.state),
              label: Row(
                children: const [
                  Icon(Icons.add),
                  Text("Add Task"),
                ],
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const Dialog(child: TaskForm());
                    });
              },
            );
          },
        ),
      ),
    );
  }
}
