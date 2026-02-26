import 'package:flutter/material.dart';

import '../app_text.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.title,
    this.width,
    this.height = 40,
    this.padding,
    this.color = const Color(0xff0099a5),
    this.textColor = Colors.white,
    this.radius = 5,
    this.fontSize = 14,
    this.fontWeight = FontWeightType.semiBold,
    required this.onPressed,
    super.key,
  });

  final String title;
  final double height;
  final double? width;
  final double fontSize;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Color textColor;
  final FontWeightType? fontWeight;
  final double radius;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: width ?? double.infinity,
          height: height,
          padding: padding,
          alignment: Alignment.center,
          child: AppText.primaryButton(
            title,
            color: textColor,
            fontWeight: fontWeight,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
