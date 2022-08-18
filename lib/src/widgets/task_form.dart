import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pomodoro/src/bloc/bloc.dart';
import 'package:pomodoro/src/constants/constants.dart';
import 'package:pomodoro/src/data/models/models.dart';
import 'package:pomodoro/src/widgets/widgets.dart';
import '../utils/helpers/helpers.dart';

class TaskForm extends StatefulWidget {
  final Task? task;
  const TaskForm({Key? key, this.task}) : super(key: key);

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController estPomodoroCtrl =
      TextEditingController(text: "1");
  final TextEditingController noteCtrl = TextEditingController();

  bool addNotes = false;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      titleCtrl.text = widget.task!.title;
      estPomodoroCtrl.text = "${widget.task!.estimatedPomodoroNum}";
      noteCtrl.text = widget.task!.note;
      addNotes = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: kWhiteColor,
        padding: EdgeInsets.all(kDefaultPadding),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  "${widget.task != null ? 'Update' : 'Add'} Task",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Gap(kDefaultPadding),
              CustomTextField(
                fixedLabel: "Title",
                controller: titleCtrl,
                hintText: "What are you working on?",
                validator: (String? value) {
                  if (value != null && value.isEmpty) {
                    return "* Required";
                  }
                  return null;
                },
              ),
              Gap(kDefaultPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomText(
                      text: "Est Pomodoros",
                      fontWeight: FontWeight.bold,
                      fontSize: kDefaultFontSize - 2,
                    ),
                  ),
                  SizedBox(
                    width: width(75),
                    child: CustomTextField(
                      controller: estPomodoroCtrl,
                      textInputType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'^(\d{0,2})'))
                      ],
                      addBottomMargin: false,
                      validator: (String? value) {
                        if (value != null && value.isEmpty) {
                          return "* Required";
                        }
                        if (value == '0') {
                          return "Mininum 1";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Gap(kDefaultPadding),
              addNotes
                  ? CustomTextField(
                      fixedLabel: "Any Notes?",
                      controller: noteCtrl,
                      maxLines: null,
                      textInputType: TextInputType.multiline,
                    )
                  : GestureDetector(
                      onTap: () => setState(() {
                        addNotes = !addNotes;
                      }),
                      child: const Text(
                        "+ Add notes",
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ),
              Gap(kDefaultPadding),
              CustomButton(
                text: widget.task != null ? "Update" : "Save",
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    FocusScope.of(context).unfocus();
                    widget.task != null
                        ? context.read<TaskCubit>().updateTask(
                              id: widget.task!.id,
                              title: titleCtrl.text.trim(),
                              note: noteCtrl.text.trim(),
                              estimatedPomodoroNum:
                                  int.tryParse(estPomodoroCtrl.text.trim()) ??
                                      1,
                              actualPomodoroNum: widget.task!.actualPomodoroNum,
                            )
                        : context.read<TaskCubit>().addTask(
                              title: titleCtrl.text.trim(),
                              note: noteCtrl.text.trim(),
                              estimatedPomodoroNum:
                                  int.tryParse(estPomodoroCtrl.text.trim()) ??
                                      1,
                              actualPomodoroNum: 0,
                            );
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
