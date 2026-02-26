import 'package:flutter/material.dart';

import '../../app/config/app_colors.dart';

enum FontFamilyType {
  roboto;
}

extension FontFamilyExtension on FontFamilyType {
  String? name() {
    switch (this) {
      case FontFamilyType.roboto:
        return "Roboto";
    }
  }
}

enum FontWeightType { light, regular, medium, semiBold, bold }

extension FontWeightTypeExtension on FontWeightType {
  FontWeight type() {
    switch (this) {
      case FontWeightType.light:
        return FontWeight.w300;
      case FontWeightType.regular:
        return FontWeight.w400;
      case FontWeightType.medium:
        return FontWeight.w500;
      case FontWeightType.semiBold:
        return FontWeight.w600;
      case FontWeightType.bold:
        return FontWeight.w700;
    }
  }
}

class AppText extends StatelessWidget {
  final TextStyle? textStyle;
  final String text;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final bool scalable;
  final String? configKey;

  const AppText._(
    this.text, {
    this.textStyle,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.configKey,
    this.scalable = false,
  });

  factory AppText.primary(
    String text, {
    Color? color = AppColors.black,
    FontWeightType? fontWeight = FontWeightType.regular,
    bool scalable = false,
    String? configKey,
    TextAlign? textAlign,
    int? maxLines,
    double? fontSize = 15.0,
    TextOverflow? overflow,
    FontFamilyType? fontFamily = FontFamilyType.roboto,
    TextDecoration decoration = TextDecoration.none,
        TextStyle style = const TextStyle(fontStyle: FontStyle.normal),
  }) {
    return AppText._(
      text,
      textStyle: TextStyle(
        fontWeight: fontWeight?.type(),
        color: color,
        fontSize: fontSize,
        fontFamily: fontFamily?.name(),
        decoration: decoration,
        overflow: overflow,
      ),
      scalable: scalable,
      configKey: configKey,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
    );
  }

  factory AppText.system(
    String text, {
    Color? color = AppColors.black,
    FontWeightType? fontWeight = FontWeightType.regular,
    bool scalable = false,
    String? configKey,
    TextAlign? textAlign,
    int? maxLines,
    double? fontSize = 16.0,
    TextDecoration decoration = TextDecoration.none,
    double? letterSpacing = .0,
    double? height,
    FontStyle? fontStyle,
  }) {
    return AppText._(
      text,
      textStyle: TextStyle(
        fontWeight: fontWeight?.type(),
        color: color,
        fontSize: fontSize,
        decoration: decoration,
        letterSpacing: letterSpacing,
        height: height,
        fontStyle: fontStyle,
      ),
      scalable: scalable,
      configKey: configKey,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
    );
  }

  factory AppText.body(
    String text, {
    Color? color = AppColors.black,
    FontWeightType? fontWeight = FontWeightType.regular,
    bool scalable = false,
    String? configKey,
    TextAlign? textAlign,
    int? maxLines,
    double? fontSize = 16.0,
    FontFamilyType? fontFamily = FontFamilyType.roboto,
    TextDecoration decoration = TextDecoration.none,
  }) {
    return AppText._(
      text,
      textStyle: TextStyle(
        fontWeight: fontWeight?.type(),
        color: color,
        fontSize: fontSize,
        fontFamily: fontFamily?.name(),
        decoration: decoration,
      ),
      scalable: scalable,
      configKey: configKey,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
    );
  }

  factory AppText.body_2(
      String text, {
        Color? color = AppColors.black,
        FontWeightType? fontWeight = FontWeightType.regular,
        bool scalable = false,
        String? configKey,
        TextAlign? textAlign,
        int? maxLines,
        double? fontSize = 13.0,
        FontFamilyType? fontFamily = FontFamilyType.roboto,
        TextDecoration decoration = TextDecoration.none,
      }) {
    return AppText._(
      text,
      textStyle: TextStyle(
        fontWeight: fontWeight?.type(),
        color: color,
        fontSize: fontSize,
        fontFamily: fontFamily?.name(),
        decoration: decoration,
      ),
      scalable: scalable,
      configKey: configKey,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
    );
  }

  factory AppText.primaryButton(
    String text, {
    Color? color = AppColors.black,
    FontWeightType? fontWeight = FontWeightType.semiBold,
    bool scalable = false,
    String? configKey,
    TextAlign? textAlign,
    int? maxLines,
    double? fontSize = 14.0,
    FontFamilyType? fontFamily = FontFamilyType.roboto,
  }) {
    return AppText._(
      text,
      textStyle: TextStyle(
        fontWeight: fontWeight?.type(),
        color: color,
        fontSize: fontSize,
        fontFamily: fontFamily?.name(),
      ),
      scalable: scalable,
      configKey: configKey,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
    );
  }

  factory AppText.regular(
    String text, {
    Color? color = AppColors.black,
    FontWeightType? fontWeight = FontWeightType.regular,
    bool scalable = false,
    String? configKey,
    TextAlign? textAlign,
    int? maxLines,
    double? fontSize = 14.0,
    FontFamilyType? fontFamily = FontFamilyType.roboto,
  }) {
    return AppText._(
      text,
      textStyle: TextStyle(
        fontWeight: fontWeight?.type(),
        color: color,
        fontSize: fontSize,
        fontFamily: fontFamily?.name(),
      ),
      scalable: scalable,
      configKey: configKey,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
    );
  }

  factory AppText.small(
    String text, {
    Color? color = AppColors.black,
    FontWeightType? fontWeight = FontWeightType.regular,
    bool scalable = false,
    String? configKey,
    TextAlign? textAlign,
    int? maxLines,
    double? fontSize = 12.0,
    FontFamilyType? fontFamily = FontFamilyType.roboto,
  }) {
    return AppText._(
      text,
      textStyle: TextStyle(
        fontWeight: fontWeight?.type(),
        color: color,
        fontSize: fontSize,
        fontFamily: fontFamily?.name(),
      ),
      scalable: scalable,
      configKey: configKey,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
    );
  }

  factory AppText.h6(
    String text, {
    Color? color = AppColors.black,
    FontWeightType? fontWeight = FontWeightType.medium,
    bool scalable = false,
    String? configKey,
    TextAlign? textAlign,
    int? maxLines,
    double? fontSize = 28.0,
    FontFamilyType? fontFamily = FontFamilyType.roboto,
  }) {
    return AppText._(
      text,
      textStyle: TextStyle(
        fontWeight: fontWeight?.type(),
        color: color,
        fontSize: fontSize,
        fontFamily: fontFamily?.name(),
      ),
      scalable: scalable,
      configKey: configKey,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
    );
  }

  factory AppText.h4(
    String text, {
    Color? color = AppColors.black,
    FontWeightType? fontWeight = FontWeightType.semiBold,
    bool scalable = false,
    String? configKey,
    TextAlign? textAlign,
    int? maxLines,
    double? fontSize = 20.0,
    FontFamilyType? fontFamily = FontFamilyType.roboto,
  }) {
    return AppText._(
      text,
      textStyle: TextStyle(
        fontWeight: fontWeight?.type(),
        color: color,
        fontSize: fontSize,
        fontFamily: fontFamily?.name(),
      ),
      scalable: scalable,
      configKey: configKey,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
    );
  }

  factory AppText.h3(
    String text, {
    Color? color = AppColors.black,
    FontWeightType? fontWeight = FontWeightType.semiBold,
    bool scalable = false,
    String? configKey,
    TextAlign? textAlign,
    int? maxLines,
    double? fontSize = 24.0,
    FontFamilyType? fontFamily = FontFamilyType.roboto,
  }) {
    return AppText._(
      text,
      textStyle: TextStyle(
        fontWeight: fontWeight?.type(),
        color: color,
        fontSize: fontSize,
        fontFamily: fontFamily?.name(),
      ),
      scalable: scalable,
      configKey: configKey,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
    );
  }

  factory AppText.mandatory(
      String text, {
        Color? color = AppColors.black,
        FontWeightType? fontWeight = FontWeightType.regular,
        bool scalable = false,
        String? configKey,
        TextAlign? textAlign,
        int? maxLines,
        double? fontSize = 16.0,
        FontFamilyType? fontFamily = FontFamilyType.roboto,
        TextDecoration decoration = TextDecoration.none,
      }) {
    return AppText._(
      text,
      textStyle: TextStyle(
        fontWeight: fontWeight?.type(),
        color: color,
        fontSize: fontSize,
        fontFamily: fontFamily?.name(),
        decoration: decoration,
      ),
      scalable: scalable,
      configKey: configKey,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      textScaler: scalable ? TextScaler.noScaling : const TextScaler.linear(1),
    );
  }
}
