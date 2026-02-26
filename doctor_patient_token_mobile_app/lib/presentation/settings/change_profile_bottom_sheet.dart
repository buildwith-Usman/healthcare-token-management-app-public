import 'package:doctor_patient_token_mobile_app/app/config/app_enum.dart';
import 'package:doctor_patient_token_mobile_app/app/config/app_icon.dart';
import 'package:doctor_patient_token_mobile_app/app/utils/util.dart';
import 'package:doctor_patient_token_mobile_app/presentation/settings/change_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/config/app_colors.dart';
import '../../app/services/app_get_view_stateful.dart';
import '../../app/utils/sizes.dart';
import '../../generated/locales.g.dart';
import '../widgets/button/round_border_button.dart';
import '../widgets/textfield/form_textfield.dart';
import '../widgets/app_text.dart';

class ChangeProfileBottomSheet
    extends GetStatefulWidget<ChangeProfileController> {
  final BottomSheetType type;

  const ChangeProfileBottomSheet({required this.type, super.key});

  @override
  State<ChangeProfileBottomSheet> createState() => _ChangeProfileBottomSheet();
}

class _ChangeProfileBottomSheet extends State<ChangeProfileBottomSheet> {
  @override
  void initState() {
    super.initState();
    widget.controller.type = widget.type;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: keyboardHeight),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: screenHeight * 0.95,
        ),
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 60),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          reverse: true, // Scroll to bottom when keyboard appears
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: AppIcon.swipe.widget()),
              gapH32,
              AppText.h3(
                widget.type == BottomSheetType.changeEmail
                    ? LocaleKeys.changeProfileScreen_headingEmail.tr
                    : LocaleKeys.changeProfileScreen_headingMobile.tr,
                fontWeight: FontWeightType.bold,
                textAlign: TextAlign.center,
                fontSize: 26,
                color: AppColors.black,
              ),
              gapH16,
              FormTextField(
                hintText: widget.type == BottomSheetType.changeEmail
                    ? LocaleKeys.changeProfileScreen_email.tr
                    : LocaleKeys.changeProfileScreen_mobNo.tr,
                borderRadius: 70,
                height: 50,
                horizontalPadding: 22,
                verticalPadding: 16,
                controller: widget.controller.textFieldTextEditingController,
                fontSize: 14,
              ),
              gapH26,
              RoundBorderButton(
                title: LocaleKeys.changeProfileScreen_submit.tr,
                color: AppColors.primary,
                onPressed: () async {
                  await widget.controller.submitData(
                    context,
                    onSucces: (success, token) {
                      if (success) {
                        // Close the bottom sheet
                        Navigator.of(context).pop();
                        if (token != null) {
                          Future.delayed(const Duration(milliseconds: 300), () {
                            widget.controller.goToOtpScreen(token);
                          });
                        } else {
                          Util.showSuccessToast(
                              message: "Phone Number Updated Successfully",
                              context: context);
                        }
                      } else {
                        // Handle failure (error message is already shown inside the method)
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
