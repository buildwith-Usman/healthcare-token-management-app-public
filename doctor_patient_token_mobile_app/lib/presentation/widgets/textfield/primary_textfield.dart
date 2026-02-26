import 'package:flutter/material.dart';

import '../../../app/config/app_colors.dart';
import '../app_text.dart';

typedef OnChangedPrimaryTextField = Function(String);

class PrimaryTextField extends StatefulWidget {
  const PrimaryTextField({
    this.controller,
    this.initialValue,
    this.hintText,
    this.height = 40,
    this.contentPadding = const EdgeInsets.only(
      left: 10,
      top: 11,
      right: 10,
      bottom: 10,
    ),
    this.errorText,
    this.backgroundColor = Colors.white,
    this.labelColor = const Color(0xff333333),
    this.autoFocus = false,
    this.textInputType,
    this.onChanged,
    this.prefixIcon,
    this.textAlign = TextAlign.left,
    this.isRequired = false,
    this.isInvalid = false,
    this.invalidText = '',
    super.key,
  });

  final TextEditingController? controller;
  final String? initialValue;
  final String? hintText;
  final double height;
  final Color backgroundColor;
  final Color labelColor;
  final bool autoFocus;
  final TextInputType? textInputType;
  final OnChangedPrimaryTextField? onChanged;
  final Widget? prefixIcon;
  final TextAlign textAlign;
  final bool isRequired;
  final bool isInvalid;
  final String invalidText;
  final String? errorText;
  final EdgeInsets contentPadding;

  @override
  State<PrimaryTextField> createState() => _PrimaryTextFieldState();
}

class _PrimaryTextFieldState extends State<PrimaryTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: widget.height,
          child: TextFormField(
            onChanged: (String value) {
              setState(() {
                if (widget.onChanged != null) {
                  widget.onChanged!(value);
                }
              });
            },
            keyboardType: widget.textInputType,
            autofocus: widget.autoFocus,
            controller: widget.controller,
            initialValue: widget.initialValue,
            textAlignVertical: TextAlignVertical.center,
            textCapitalization: TextCapitalization.sentences,
            textAlign: widget.textAlign,
            style: const TextStyle(color: Color(0xff333333), fontSize: 14),
            decoration: InputDecoration(
              prefixIconConstraints: BoxConstraints.tightFor(
                width: widget.height,
                height: widget.height,
              ),
              contentPadding: widget.contentPadding,
              alignLabelWithHint: true,
              filled: true,
              isDense: true,
              fillColor: widget.backgroundColor,
              border: const OutlineInputBorder(),
              hintText: widget.hintText,
              errorText: widget.errorText,
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.controller != null &&
                      widget.controller!.text.isNotEmpty
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          widget.controller!.clear();
                          if (widget.onChanged != null) {
                            widget.onChanged!('');
                          }
                        });
                      },
                      child: const Icon(
                        Icons.close_rounded,
                        size: 17,
                      ),
                    )
                  : null,
              enabledBorder: const  OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xffE0E0E0),
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xff428BCA),
                ),
              ),
              hintStyle: const TextStyle(
                color: AppColors.todoTitle,
                fontSize: 14,
              ),
            ),
          ),
        ),
        if (widget.isRequired && widget.isInvalid) ...[
          const SizedBox(height: 2),
          AppText.primary(
            widget.invalidText,
            fontSize: 11,
            color: AppColors.red513,
          )
        ]
      ],
    );
  }
}
