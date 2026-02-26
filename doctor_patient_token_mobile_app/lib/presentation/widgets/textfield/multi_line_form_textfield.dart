import 'package:doctor_patient_token_mobile_app/presentation/widgets/textfield/form_textfield.dart';
import 'package:flutter/material.dart';

class MultiLineFormTextField extends StatelessWidget {
  const MultiLineFormTextField({
    super.key,
    this.controller,
    this.titleText = '',
    this.hintText,
    this.initialValue,
    this.onChanged,
    this.isRequired = false,
    this.readOnly = false,
    this.isInvalid = false,
    this.invalidText = '',
    this.errorText,
    this.maxLines = 5,
    this.backgroundColor = Colors.white,
    this.borderRadius = 20,
    this.fontSize = 14,
    this.minHeight = 100, // 👈 default flexible height
  });

  final TextEditingController? controller;
  final String titleText;
  final String? hintText;
  final String? initialValue;
  final Function(String)? onChanged;
  final bool isRequired;
  final bool readOnly;
  final bool isInvalid;
  final String invalidText;
  final String? errorText;
  final int maxLines;
  final Color backgroundColor;
  final double borderRadius;
  final double fontSize;
  final double minHeight;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: minHeight),
      child: FormTextField(
        titleText: titleText,
        controller: controller,
        hintText: hintText,
        initialValue: initialValue,
        onChanged: onChanged,
        isRequired: isRequired,
        readOnly: readOnly,
        isInvalid: isInvalid,
        invalidText: invalidText,
        errorText: errorText,
        maxLines: maxLines,
        backgroundColor: backgroundColor,
        borderRadius: borderRadius,
        fontSize: fontSize,
        height: minHeight, // 👈 pass a valid height
      ),
    );
  }
}
