import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pomodoro/src/bloc/bloc.dart';
import 'package:pomodoro/src/constants/constants.dart';
import 'package:pomodoro/src/data/enum/enum.dart';
import 'package:pomodoro/src/utils/utils.dart';
import 'package:pomodoro/src/widgets/custom_alert.dart';
import 'package:pomodoro/src/widgets/widgets.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.all(kDefaultMargin),
          padding: EdgeInsets.symmetric(
            vertical: kDefaultPadding * 2,
          ),
          decoration: BoxDecoration(
            color: kTransparentColor.withAlpha(30),
            borderRadius: BorderRadius.circular(radius(15)),
          ),
          child: Row(
            children: [
              const SizedBox(width: kIsWeb ? 200 : 150, child: _MainButtons()),
              Gap(width(25)),
              const Expanded(child: _TimerSection()),
            ],
          ),
        );
      },
    );
  }
}

class _MainButtons extends StatelessWidget {
  const _MainButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pomodoroCubit = context.read<PomodoroCubit>();
    return BlocBuilder<PomodoroCubit, PomodoroState>(builder: (context, state) {
      return Container(
        padding: EdgeInsets.all(kDefaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomButton(
              text: "Pomodoro",
              color: state.state == PomodoroEnum.pomodoro
                  ? kTransparentColor.withAlpha(50)
                  : kTransparentColor,
              borderRadius: 50,
              onPressed: () async {
                if (context.read<TimerBloc>().state is TimerRunInProgress) {
                  final bool result = await customAlert(
                    context: context,
                    msg: "Timer is still running",
                    btnColor: getColorForState(pomodoroCubit.state.state),
                  );
                  if (result) {
                    if (pomodoroCubit.state.state != PomodoroEnum.pomodoro) {
                      pomodoroCubit
                        ..selectState(PomodoroEnum.pomodoro)
                        ..shortBreakCount = 0;
                    }
                  }
                } else {
                  if (pomodoroCubit.state.state != PomodoroEnum.pomodoro) {
                    pomodoroCubit
                      ..selectState(PomodoroEnum.pomodoro)
                      ..shortBreakCount = 0;
                  }
                }
              },
            ),
            const Gap(5),
            CustomButton(
              text: "Short Break",
              color: state.state == PomodoroEnum.shortBreak
                  ? kTransparentColor.withAlpha(50)
                  : kTransparentColor,
              borderRadius: 50,
              onPressed: () async {
                if (context.read<TimerBloc>().state is TimerRunInProgress) {
                  final bool result = await customAlert(
                    context: context,
                    msg: "Timer is still running",
                    btnColor: getColorForState(pomodoroCubit.state.state),
                  );
                  if (result) {
                    if (pomodoroCubit.state.state != PomodoroEnum.shortBreak) {
                      pomodoroCubit.selectState(PomodoroEnum.shortBreak);
                    }
                  }
                } else {
                  if (pomodoroCubit.state.state != PomodoroEnum.shortBreak) {
                    pomodoroCubit.selectState(PomodoroEnum.shortBreak);
                  }
                }
              },
            ),
            const Gap(5),
            CustomButton(
              text: "Long Break",
              color: state.state == PomodoroEnum.longBreak
                  ? kTransparentColor.withAlpha(50)
                  : kTransparentColor,
              borderRadius: 50,
              onPressed: () async {
                if (context.read<TimerBloc>().state is TimerRunInProgress) {
                  final bool result = await customAlert(
                    context: context,
                    msg: "Timer is still running",
                    btnColor: getColorForState(pomodoroCubit.state.state),
                  );
                  if (result) {
                    if (pomodoroCubit.state.state != PomodoroEnum.longBreak) {
                      pomodoroCubit.selectState(PomodoroEnum.longBreak);
                    }
                  }
                } else {
                  if (pomodoroCubit.state.state != PomodoroEnum.longBreak) {
                    pomodoroCubit.selectState(PomodoroEnum.longBreak);
                  }
                }
              },
            ),
          ],
        ),
      );
    });
  }
}

class _TimerSection extends StatelessWidget {
  const _TimerSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pomodoroCubit = context.read<PomodoroCubit>();
    final timerBloc = context.read<TimerBloc>();
    return BlocConsumer<TimerBloc, TimerState>(
      listener: (context, state) {
        if (state is TimerRunComplete) {
          if (pomodoroCubit.state.state == PomodoroEnum.pomodoro) {
            context.read<TaskCubit>().updateActualPomodoroCount();
          }
          context.read<PomodoroCubit>().onTimerComplete();
        }
      },
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(kDefaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                child: Text(
                  formatDuration(state.duration),
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        color: kWhiteColor,
                      ),
                ),
              ),
              Gap(height(25)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (state is TimerInitial || state is TimerRunPause) ...[
                    Container(
                      width: width(100),
                      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                      child: CustomButton(
                        text: "START",
                        color: kWhiteColor,
                        textColor: getColorForState(pomodoroCubit.state.state),
                        fontWeight: FontWeight.bold,
                        onPressed: () =>
                            timerBloc.add(TimerStarted(state.duration)),
                      ),
                    ),
                  ] else if (state is TimerRunInProgress) ...[
                    SizedBox(
                      width: width(100),
                      child: CustomButton(
                        text: "STOP",
                        color: kWhiteColor,
                        textColor: getColorForState(pomodoroCubit.state.state),
                        fontWeight: FontWeight.bold,
                        onPressed: () => timerBloc.add(const TimerPaused()),
                      ),
                    ),
                    IconButton(
                      splashRadius: 0.1,
                      onPressed: () async {
                        final bool result = await customAlert(
                          context: context,
                          msg: "You want to finish the round early?",
                          btnColor: getColorForState(pomodoroCubit.state.state),
                        );
                        if (result) {
                          if (pomodoroCubit.state.state ==
                              PomodoroEnum.pomodoro) {
                            context
                                .read<TaskCubit>()
                                .updateActualPomodoroCount();
                          }
                          pomodoroCubit
                              .selectState(pomodoroCubit.getNextState());
                        }
                      },
                      icon: const Icon(Icons.skip_next, color: kWhiteColor),
                    ),
                  ]
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

// class ActionButtons extends StatelessWidget {
//   const ActionButtons({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final timerBloc = context.read<TimerBloc>();
//     final pomodoroCubit = context.read<PomodoroCubit>();

//     return BlocBuilder<TimerBloc, TimerState>(
//       builder: (context, state) {
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             if (state is TimerInitial || state is TimerRunPause) ...[
//               Expanded(
//                 child: CustomButton(
//                   text: "START",
//                   color: kWhiteColor,
//                   textColor: kBlackColor,
//                   fontWeight: FontWeight.bold,
//                   onPressed: () => timerBloc.add(TimerStarted(state.duration)),
//                 ),
//               ),
//             ] else if (state is TimerRunInProgress) ...[
//               Expanded(
//                 child: CustomButton(
//                   text: "STOP",
//                   color: kWhiteColor,
//                   textColor: kBlackColor,
//                   fontWeight: FontWeight.bold,
//                   onPressed: () => timerBloc.add(const TimerPaused()),
//                 ),
//               ),
//               IconButton(
//                 splashRadius: 0.1,
//                 onPressed: () {
//                   pomodoroCubit.selectState(pomodoroCubit.getNextState());
//                 },
//                 icon: const Icon(Icons.skip_next, color: kWhiteColor),
//               ),
//               // FloatingActionButton(
//               //     child: const Icon(Icons.refresh),
//               //     onPressed: () =>
//               //         context.read<TimerBloc>().add(const TimerReset())),
//             ] else if (state is TimerRunPause) ...[
//               // Expanded(
//               //   child: CustomButton(
//               //     text: "START",
//               //     onPressed: () => timerBloc.add(TimerResumed(state.duration)),
//               //   ),
//               // ),
//               // FloatingActionButton(
//               //     child: const Icon(Icons.refresh),
//               //     onPressed: () =>
//               //         context.read<TimerBloc>().add(const TimerReset())),
//             ] else if (state is TimerRunComplete) ...[
//               // FloatingActionButton(
//               //     child: const Icon(Icons.refresh),
//               //     onPressed: () =>
//               //         context.read<TimerBloc>().add(const TimerReset()))
//             ],
//           ],
//         );
//       },
//     );
//   }
// }
