import 'package:doctor_patient_token_mobile_app/app/config/app_colors.dart';
import 'package:doctor_patient_token_mobile_app/app/utils/app_extensions.dart';
import 'package:doctor_patient_token_mobile_app/presentation/doctor_dashboard/filter_bottom_sheet_controller.dart';
import 'package:doctor_patient_token_mobile_app/presentation/widgets/app_button.dart';

import 'package:flutter/material.dart';

import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../app/config/app_icon.dart';
import '../../app/services/app_get_view_stateful.dart';
import '../../app/utils/sizes.dart';
import '../patient_dashboard/patient_dashboard_page.dart';
import '../widgets/app_text.dart';
import '../widgets/button/round_border_button.dart';
import '../widgets/custom_check_box.dart';

class FilterBottomSheet extends GetStatefulWidget<FilterBottomSheetController> {
  final OnFilterSubmit onSubmit;

  const FilterBottomSheet({super.key, required this.onSubmit});

  @override
  State<StatefulWidget> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: AppIcon.swipe.widget()),
              gapH32,
              AppText.h3("Filter",
                  fontWeight: FontWeightType.bold,
                  textAlign: TextAlign.center,
                  fontSize: 26,
                  color: AppColors.black),
              gapH12,
              Column(
                children: [
                  GestureDetector(
                    onTap: () => widget.controller.toggleShift('morning'),
                    child: Row(
                      children: [
                        CustomCheckbox(
                          isSelected:
                              widget.controller.selectedShift.value == 'morning',
                        ),
                        gapW6,
                        AppText.primary('Morning', fontSize: 14),
                      ],
                    ),
                  ),
                  gapH16,
                  GestureDetector(
                    onTap: () => widget.controller.toggleShift('evening'),
                    child: Row(
                      children: [
                        CustomCheckbox(
                          isSelected:
                              widget.controller.selectedShift.value == 'evening',
                        ),
                        gapW6,
                        AppText.primary('Evening', fontSize: 14),
                      ],
                    ),
                  ),
                ],
              ),
              gapH16,
              AppButton(
                  title: widget.controller.selectedDate.value
                      .dateToStringWithFormat(format: "MMMM dd, yyyy"),
                  height: 50,
                  color: Colors.transparent,
                  borderColor: AppColors.grey80,
                  radius: 70,
                  fontWeight: FontWeightType.regular,
                  textColor: AppColors.black,
                  icon: AppIcon.icCalender.widget(),
                  onPressed: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2023),
                      lastDate: DateTime(2030),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        widget.controller.updateDate(pickedDate);
                      });
                    }
                  }),
              gapH40,
              RoundBorderButton(
                  title: "Submit", color: AppColors.primary, onPressed: () {
                final selectedDate = widget.controller.selectedDate.value;
                final selectedShift = widget.controller.selectedShift.value;
                widget.onSubmit(selectedDate, selectedShift); // ✅ call the callback
                Navigator.pop(context);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
