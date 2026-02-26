import 'package:doctor_patient_token_mobile_app/app/config/app_icon.dart';
import 'package:doctor_patient_token_mobile_app/app/utils/app_extensions.dart';
import 'package:doctor_patient_token_mobile_app/app/utils/sizes.dart';
import 'package:doctor_patient_token_mobile_app/app/utils/util.dart';
import 'package:doctor_patient_token_mobile_app/presentation/time_update_bottom_sheet/time_update_bottom_sheet_controller.dart';
import 'package:doctor_patient_token_mobile_app/presentation/widgets/app_text.dart';
import 'package:doctor_patient_token_mobile_app/presentation/widgets/textfield/form_textfield.dart';
import 'package:doctor_patient_token_mobile_app/presentation/widgets/textfield/multi_line_form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:time_range_picker/time_range_picker.dart';

import '../../app/config/app_colors.dart';
import '../../app/services/app_get_view_stateful.dart';
import '../../generated/locales.g.dart';
import '../widgets/button/round_border_button.dart';
import 'package:get/get.dart';

class TimeUpdateBottomSheet
    extends GetStatefulWidget<TimeUpdateBottomSheetController> {
  const TimeUpdateBottomSheet({super.key});

  @override
  State<TimeUpdateBottomSheet> createState() => _TimeUpdateBottomSheetState();
}

class _TimeUpdateBottomSheetState extends State<TimeUpdateBottomSheet> {
  void _showShiftDisableInstructions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              const Icon(Icons.info, color: AppColors.primary),
              const SizedBox(width: 8),
              AppText.primary(
                'Shift Disable Instructions',
                fontWeight: FontWeightType.bold,
                fontSize: 18,
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText.primary(
                  'Pattern Format:',
                  fontWeight: FontWeightType.bold,
                  fontSize: 14,
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: AppText.primary(
                    'weekly:Sunday:both, date:2025-06-15:evening, date:2025-06-18:both',
                    fontSize: 12,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 16),
                AppText.primary(
                  'Components:',
                  fontWeight: FontWeightType.bold,
                  fontSize: 14,
                ),
                const SizedBox(height: 8),
                _buildInstructionRow('Type:', 'weekly or date'),
                _buildInstructionRow('Value:', 'Sunday or specific date (YYYY-MM-DD)'),
                _buildInstructionRow('Shift:', 'morning, evening, or both'),
                const SizedBox(height: 16),
                AppText.primary(
                  'Examples:',
                  fontWeight: FontWeightType.bold,
                  fontSize: 14,
                ),
                const SizedBox(height: 8),
                _buildExampleRow('Weekly disable:', 'weekly:Sunday:both'),
                _buildExampleRow('Date disable:', 'date:2025-06-15:evening'),
                _buildExampleRow('Multiple:', 'weekly:Sunday:morning, date:2025-06-18:both'),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.lightbulb_outline, color: AppColors.primary, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: AppText.primary(
                          'Separate multiple patterns with commas',
                          fontSize: 12,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: AppText.primary(
                'Got it',
                color: AppColors.primary,
                fontWeight: FontWeightType.bold,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInstructionRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 60,
            child: AppText.primary(
              label,
              fontWeight: FontWeightType.semiBold,
              fontSize: 12,
            ),
          ),
          Expanded(
            child: AppText.primary(
              value,
              fontSize: 12,
              color: AppColors.grey60,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExampleRow(String label, String example) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.primary(
            label,
            fontWeight: FontWeightType.semiBold,
            fontSize: 12,
          ),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(6),
            ),
            child: AppText.primary(
              example,
              fontSize: 11,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 60, left: 20, right: 20, top: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 60,
              height: 5,
              margin: const EdgeInsets.only(bottom: 30),
              decoration: BoxDecoration(
                color: AppColors.grey90,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          gapH8,
          AppText.primary(
            LocaleKeys.timeUpdateBottom_timeUpdate.tr,
            fontSize: 22,
            fontWeight: FontWeightType.bold,
          ),
          gapH8,
          AppText.primary(
            LocaleKeys.timeUpdateBottom_updateTheAppointmentTime.tr,
            fontSize: 14,
            color: AppColors.grey60,
          ),
          gapH16,
          Obx(() {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.lightGrey,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: RoundBorderButton(
                        height: 40,
                        radius: 8,
                        title: LocaleKeys.timeUpdateBottom_morning.tr,
                        color:
                            widget.controller.selectedShift.value == "morning"
                                ? AppColors.primary
                                : AppColors.lightGrey,
                        textColor:
                            widget.controller.selectedShift.value == "morning"
                                ? AppColors.white
                                : AppColors.black,
                        onPressed: () {
                          widget.controller.toggleShift('morning');
                        },
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: RoundBorderButton(
                        height: 40,
                        radius: 8,
                        title: LocaleKeys.timeUpdateBottom_evening.tr,
                        color:
                            widget.controller.selectedShift.value == "evening"
                                ? AppColors.primary
                                : AppColors.lightGrey,
                        textColor:
                            widget.controller.selectedShift.value == "evening"
                                ? AppColors.white
                                : AppColors.black,
                        onPressed: () {
                          widget.controller.toggleShift('evening');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          gapH16,
          AppText.primary(
            LocaleKeys.timeUpdateBottom_appointmentTime.tr,
            fontWeight: FontWeightType.bold,
          ),
          gapH16,
          Obx(
            () => GestureDetector(
              onTap: () async {
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
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    AppText.primary(
                        widget.controller.selectedDate.value
                            .dateToStringWithFormat(format: "MMMM dd, yyyy"),
                        color: AppColors.grey60),
                    const Spacer(),
                    AppIcon.icCalender.widget(),
                  ],
                ),
              ),
            ),
          ),
          gapH16,
          Obx(
            () => GestureDetector(
              onTap: () async {
                final TimeRange? result = await showTimeRangePicker(
                    context: context,
                    start: const TimeOfDay(hour: 9, minute: 0),
                    end: const TimeOfDay(hour: 17, minute: 0),
                    use24HourFormat: true);
                final startTime = result?.startTime;
                final startHour = startTime?.hour.toString().padLeft(2, '0');
                final startMinute =
                    startTime?.minute.toString().padLeft(2, '0');

                final endTime = result?.endTime;
                final endHour = endTime?.hour.toString().padLeft(2, '0');
                final endMinute = endTime?.minute.toString().padLeft(2, '0');

                if (widget.controller.selectedShift.value == 'morning') {
                  widget.controller.morningShiftStartTime.value =
                      "$startHour:$startMinute";
                  widget.controller.morningShiftEndTime.value =
                      "$endHour:$endMinute";
                } else {
                  widget.controller.eveningShiftStartTime.value =
                      "$startHour:$startMinute";
                  widget.controller.eveningShiftEndTime.value =
                      "$endHour:$endMinute";
                }
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 17),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: AppColors.black),
                ),
                child: Row(
                  children: [
                    AppText.primary(
                        LocaleKeys.timeUpdateBottom_startEndTime.tr),
                    const Spacer(),
                    AppText.primary(
                      widget.controller.selectedShift.value == "morning"
                          ? "${widget.controller.morningShiftStartTime.value} - ${widget.controller.morningShiftEndTime.value}"
                          : "${widget.controller.eveningShiftStartTime.value} - ${widget.controller.eveningShiftEndTime.value}",
                    ),
                  ],
                ),
              ),
            ),
          ),
          gapH16,
          Row(
            children: [
              Expanded(
                child: MultiLineFormTextField(
                  titleText: 'Shift Disable',
                  controller: widget.controller.shiftDisableController,
                  hintText: "Shift Disabled Time (Optional)",
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: IconButton(
                  icon: const Icon(
                    Icons.info_outline,
                    color: AppColors.primary,
                    size: 24,
                  ),
                  onPressed: () {
                    _showShiftDisableInstructions(context);
                  },
                ),
              ),
            ],
          ),
          gapH16,
          RoundBorderButton(
            color: AppColors.primary,
            textColor: AppColors.white,
            title: LocaleKeys.timeUpdateBottom_submit.tr,
            onPressed: () async {
              await widget.controller.updateGeneralSettings(
                  onSuccess: (bool success) {
                if (success) {
                  Util.showSuccessToast(
                      message: "Settings Updated Successfully",
                      context: context);
                  Navigator.pop(context);
                } else {
                  print("Failed to fetch settings");
                }
              });
            },
          )
        ],
      ),
    );
  }
}
