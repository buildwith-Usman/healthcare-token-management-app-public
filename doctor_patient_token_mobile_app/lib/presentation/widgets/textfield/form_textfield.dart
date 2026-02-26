import 'package:doctor_patient_token_mobile_app/app/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app/config/app_colors.dart';
import '../app_text.dart';

typedef OnChangedFormTextField = Function(String);

class FormTextField extends StatefulWidget {
  const FormTextField({
    this.titleText = '',
    this.controller,
    this.initialValue,
    this.hintText,
    this.height = 60,
    this.errorText,
    this.backgroundColor = Colors.white,
    this.labelColor = const Color(0xff333333),
    this.autoFocus = false,
    this.textInputType,
    this.onChanged,
    this.prefixIcon,
    this.maxLines = 1,
    this.textAlign = TextAlign.left,
    this.isRequired = false,
    this.readOnly = false,
    this.isInvalid = false,
    this.invalidText = '',
    this.inputFormatters,
    this.enableSuggestions = true,
    this.autocorrect = true,
    this.borderRadius = 50,
    this.horizontalPadding = 15.0,
    this.verticalPadding = 15.0,
    this.borderWidth = 1,
    this.isPasswordField = false,
    this.fontSize = 14,
    this.suffixIcon,
    this.onSuffixIconTap,
    super.key,
  });

  final TextEditingController? controller;
  final String titleText;
  final String? initialValue;
  final String? hintText;
  final double height;
  final Color backgroundColor;
  final Color labelColor;
  final bool autoFocus;
  final TextInputType? textInputType;
  final OnChangedFormTextField? onChanged;
  final Widget? prefixIcon;
  final TextAlign textAlign;
  final int maxLines;
  final bool isRequired;
  final bool readOnly;
  final bool isInvalid;
  final String invalidText;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatters;
  final bool enableSuggestions;
  final bool autocorrect;
  final double borderRadius;
  final double horizontalPadding;
  final double verticalPadding;
  final double borderWidth;
  final bool isPasswordField;
  final double fontSize;
  final Widget? suffixIcon;
  final VoidCallback? onSuffixIconTap;

  @override
  State<FormTextField> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  final FocusNode _textFormFieldFocusNode = FocusNode();
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _isPasswordVisible = false;
    // Listen to focus changes on the text field
    _textFormFieldFocusNode.addListener(() {
      if (_textFormFieldFocusNode.hasFocus) {
        // When the text field gains focus, do something according to your needs
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool obscure = widget.isPasswordField && !_isPasswordVisible;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            gapW4,
            Text(
              widget.titleText,
              style: TextStyle(
                color: AppColors.black,
                fontSize: widget.fontSize,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (widget.isRequired) ...[
              const SizedBox(width: 2),
              const Text(
                '*',
                style: TextStyle(
                  color: Color(0xffE61513),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
        if (widget.titleText.isNotEmpty) gapH10,
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
            focusNode: _textFormFieldFocusNode,
            keyboardType: widget.textInputType,
            autofocus: widget.autoFocus,
            controller: widget.controller,
            inputFormatters: widget.inputFormatters,
            initialValue:
                widget.controller == null ? widget.initialValue : null,
            enableSuggestions: widget.enableSuggestions,
            autocorrect: widget.autocorrect,
            textAlignVertical: TextAlignVertical.center,
            textCapitalization: TextCapitalization.sentences,
            textAlign: widget.textAlign,
            cursorColor: AppColors.blueCA,
            maxLines: widget.maxLines,
            readOnly: widget.readOnly,
            obscureText: obscure,
            style: TextStyle(
                color: AppColors.todoTitle, fontSize: widget.fontSize),
            decoration: InputDecoration(
              suffixIconConstraints: BoxConstraints.tightFor(
                width: widget.height,
                height: widget.height,
              ),
              contentPadding: const EdgeInsets.all(15.0).copyWith(
                top: widget.verticalPadding,
                bottom: widget.verticalPadding,
                left: widget.horizontalPadding,
                right: widget.horizontalPadding,
              ),
              alignLabelWithHint: true,
              filled: true,
              isDense: true,
              fillColor: widget.backgroundColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              hintText: widget.hintText,
              errorText: widget.errorText,
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon != null
                  ? GestureDetector(
                      onTap: widget.onSuffixIconTap,
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: widget.suffixIcon,
                      ),
                    )
                  : widget.isPasswordField
                      ? IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        )
                      : null,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(
                  width: widget.borderWidth,
                  color: widget.isInvalid
                      ? AppColors.red513
                      : const Color(0xffE0E0E0),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(
                  width: widget.borderWidth,
                  color: widget.isInvalid
                      ? AppColors.red513
                      : const Color(0xff030A18),
                ),
              ),
              hintStyle:
                  TextStyle(color: Colors.grey, fontSize: widget.fontSize),
            ),
          ),
        ),
        if (widget.isRequired && widget.isInvalid) ...[
          const SizedBox(height: 2),
          AppText.primary(
            widget.invalidText,
            fontSize: 11,
            color: AppColors.red513,
          ),
        ],
      ],
    );
  }

  Widget? get _clearButton {
    if (widget.controller != null && widget.controller!.text.isNotEmpty) {
      return InkWell(
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
          size: 17.0,
          color: AppColors.todoTitle,
        ),
      );
    }

    return null;
  }

  @override
  void dispose() {
    _textFormFieldFocusNode
        .dispose(); // Clean up the focus node when not needed
    super.dispose();
  }
}
