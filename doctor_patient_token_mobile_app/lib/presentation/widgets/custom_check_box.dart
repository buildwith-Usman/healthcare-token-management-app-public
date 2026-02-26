import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app/config/app_colors.dart';

class CustomCheckbox extends StatelessWidget {
  final bool isSelected;

  const CustomCheckbox({super.key, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.white : Colors.transparent,
        border: Border.all(color: isSelected ? AppColors.primary : Colors.black, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      alignment: Alignment.center,
      child: isSelected
          ? const Text(
        '✔',
        style: TextStyle(
          color: AppColors.primary,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      )
          : null,
    );
  }
}
