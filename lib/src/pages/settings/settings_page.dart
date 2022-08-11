import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pomodoro/src/bloc/bloc.dart';
import 'package:pomodoro/src/constants/app_colors.dart';
import 'package:pomodoro/src/constants/app_constants.dart';
import 'package:pomodoro/src/data/enum/enum.dart';
import 'package:pomodoro/src/data/models/setting_model.dart';
import 'package:pomodoro/src/utils/helpers/helpers.dart';
import 'package:pomodoro/src/widgets/widgets.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController pomodoroCtrl;
  late TextEditingController shortBreakCtrl;
  late TextEditingController longBreakCtrl;
  late TextEditingController longBreakIntervalCtrl;
  bool autoShortBreak = false;
  bool autoLongBreak = false;

  late SettingsBloc settingBloc;

  @override
  void initState() {
    super.initState();
    settingBloc = context.read<SettingsBloc>();
    setFields(settingBloc.state.settings);
  }

  void setFields(SettingModel setting) {
    pomodoroCtrl = TextEditingController(
      text: (setting.timerPomodoro ~/ 60).toString(),
    );
    shortBreakCtrl = TextEditingController(
      text: (setting.timerShortBreak ~/ 60).toString(),
    );
    longBreakCtrl = TextEditingController(
      text: (setting.timerLongBreak ~/ 60).toString(),
    );
    longBreakIntervalCtrl = TextEditingController(
      text: setting.longBreakInterval.toString(),
    );
    autoLongBreak = setting.autoLongBreak;
    autoShortBreak = setting.autoShortBreaks;
  }

  @override
  void dispose() {
    super.dispose();
    pomodoroCtrl.dispose();
    shortBreakCtrl.dispose();
    longBreakCtrl.dispose();
    longBreakIntervalCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PomodoroCubit pomodoroCubit = context.read<PomodoroCubit>();
    return Scaffold(
      backgroundColor: getColorForState(pomodoroCubit.state.state),
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(kDefaultPadding),
          child: Form(
            key: formKey,
            child: BlocConsumer<SettingsBloc, SettingsState>(
              listener: (context, state) {
                if (state.status.isSuccess) {
                  showSnackbar(context, "Settings Updated");
                  Navigator.pop(context, "success");
                }
                if (state.status.isError) {
                  showSnackbar(context, "Failed to updates settings");
                }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: "Time (minutes)",
                      fontWeight: FontWeight.bold,
                      isTitle: true,
                    ),
                    Gap(height(15)),
                    _Item(title: "Pomodoro", ctrl: pomodoroCtrl),
                    _Item(title: "Short Break", ctrl: shortBreakCtrl),
                    _Item(title: "Long Break", ctrl: longBreakCtrl),
                    const Divider(),
                    Gap(height(10)),
                    _Item(
                      title: "Long Break Interval",
                      ctrl: longBreakIntervalCtrl,
                      isTitle: true,
                    ),
                    const Divider(),
                    Gap(height(10)),
                    SwitchListTile.adaptive(
                      contentPadding: EdgeInsets.zero,
                      value: autoShortBreak,
                      title: const CustomText(
                        text: "Auto Short Break",
                        fontWeight: FontWeight.bold,
                      ),
                      onChanged: (value) {
                        setState(() {
                          autoShortBreak = value;
                        });
                      },
                    ),
                    SwitchListTile.adaptive(
                      contentPadding: EdgeInsets.zero,
                      value: autoLongBreak,
                      title: const CustomText(
                        text: "Auto Long Break",
                        fontWeight: FontWeight.bold,
                      ),
                      onChanged: (value) {
                        setState(() {
                          autoLongBreak = value;
                        });
                      },
                    ),
                    const Divider(),
                    Gap(height(10)),
                    CustomButton(
                      text: state.status.isLoading ? "Processing..." : "Save",
                      color: kWhiteColor,
                      textColor: getColorForState(pomodoroCubit.state.state),
                      fontWeight: FontWeight.bold,
                      onPressed: state.status.isLoading
                          ? null
                          : () {
                              if (formKey.currentState!.validate()) {
                                FocusScope.of(context).unfocus();
                                final setting = state.settings.copyWith(
                                  timerPomodoro: getTimeInSecondFromString(
                                      pomodoroCtrl.text),
                                  timerShortBreak: getTimeInSecondFromString(
                                      shortBreakCtrl.text),
                                  timerLongBreak: getTimeInSecondFromString(
                                      longBreakCtrl.text),
                                  longBreakInterval: int.tryParse(
                                          longBreakIntervalCtrl.text) ??
                                      1,
                                  autoLongBreak: autoLongBreak,
                                  autoShortBreaks: autoShortBreak,
                                );
                                settingBloc.add(
                                    SettingsUpdateEvent(settingModel: setting));
                              }
                            },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  int getTimeInSecondFromString(String time) {
    final value = int.tryParse(time) ?? 1;
    return value * 60;
  }
}

class _Item extends StatelessWidget {
  final String title;
  final TextEditingController ctrl;
  final bool isTitle;
  const _Item({
    Key? key,
    required this.title,
    required this.ctrl,
    this.isTitle = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: kDefaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: CustomText(
              text: title,
              color: kWhiteColor,
              fontWeight: FontWeight.bold,
              fontSize: isTitle ? kDefaultFontSize : kDefaultFontSize - 2,
            ),
          ),
          SizedBox(
            width: width(100),
            child: CustomTextField(
              controller: ctrl,
              textInputType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^(\d{0,2})'))
              ],
              addBottomMargin: false,
              validator: (String? value) {
                if (value != null && value.isEmpty) {
                  return "* Required";
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
