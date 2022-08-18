import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pomodoro/src/constants/constants.dart';
import 'package:pomodoro/src/utils/helpers/size_config.dart' as size;
import 'package:pomodoro/src/widgets/widgets.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final VoidCallback? onTap;
  final bool readOnly;
  final IconData? suffixIcon;
  final int? maxLines;
  final int? maxLength;
  final bool autoFocus;
  final String? fixedLabel;
  final TextInputType textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final bool addBottomMargin;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final String? initialValue;
  final Function(String)? onChanged;

  const CustomTextField({
    Key? key,
    this.hintText,
    this.controller,
    this.onTap,
    this.readOnly = false,
    this.suffixIcon,
    this.maxLines = 1,
    this.maxLength,
    this.autoFocus = false,
    this.fixedLabel,
    this.textInputType = TextInputType.text,
    this.inputFormatters,
    this.addBottomMargin = true,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.initialValue,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          !addBottomMargin ? null : EdgeInsets.only(bottom: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (fixedLabel != null) ...[
            CustomText(
              text: fixedLabel!.toSentence,
              fontSize: kDefaultFontSize - 2,
            ),
            Gap(size.height(10)),
          ],
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size.radius(10))),
            child: TextFormField(
              initialValue: initialValue,
              validator: validator,
              autofocus: autoFocus,
              autovalidateMode: autovalidateMode,
              maxLines: maxLines,
              maxLength: maxLength,
              keyboardType: textInputType,
              readOnly: readOnly,
              onTap: onTap,
              controller: controller,
              style: GoogleFonts.getFont('Inter'),
              decoration: InputDecoration(
                filled: true,
                fillColor: kLightGrey.withOpacity(0.75),
                errorMaxLines: 2,
                // border: InputBorder.none,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: kGrey.withOpacity(0.5)),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: kPrimary),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kGrey.withOpacity(0.5)),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                hintText: hintText,
                contentPadding: EdgeInsets.all(size.height(10)),
                suffixIcon: suffixIcon == null
                    ? null
                    : Icon(
                        suffixIcon,
                        color: Colors.grey,
                      ),
              ),
              inputFormatters: inputFormatters,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
