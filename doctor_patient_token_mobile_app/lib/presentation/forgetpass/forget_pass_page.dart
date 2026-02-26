import 'package:doctor_patient_token_mobile_app/presentation/forgetpass/forget_pass_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/config/app_colors.dart';
import '../../app/config/app_enum.dart';
import '../../app/config/app_icon.dart';
import '../../app/services/app_get_view_stateful.dart';
import '../../app/utils/sizes.dart';
import '../../gen/assets.gen.dart';
import '../../generated/locales.g.dart';
import '../widgets/app_text.dart';
import '../widgets/button/round_border_button.dart';
import '../widgets/textfield/form_textfield.dart';

class ForgetPassPage extends GetStatefulWidget<ForgetPassController> {
  const ForgetPassPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ForgetPassPageState();
  }
}

class _ForgetPassPageState extends State<ForgetPassPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: _buildForgetPassPageContent(),
    );
  }

  Widget _buildForgetPassPageContent() {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final screenHeight = constraints.maxHeight;
          final screenWidth = constraints.maxWidth;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Obx(
                () => Column(
                  children: [
                    Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          top: 0,
                          left: 0,
                          child: InkWell(
                            child: AppIcon.leftArrowIcon
                                .widget(height: 24, width: 24),
                            onTap: () {
                              widget.controller.goToPreviousScreen();
                            },
                          ),
                        ),
                        Center(child: Assets.images.logo.image()),
                      ],
                    ),
                    gapH74,
                    AppText.h3(
                      widget.controller.screenOpenedFrom.value ==
                              ScreenName.setting
                          ? LocaleKeys.forgetPassScreen_changePasswordHeading.tr
                          : LocaleKeys.forgetPassScreen_heading.tr,
                      fontWeight: FontWeightType.bold,
                      textAlign: TextAlign.center,
                      fontSize: 26,
                    ),
                    gapH16,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: AppText.primary(
                        textAlign: TextAlign.center,
                        widget.controller.screenOpenedFrom.value ==
                            ScreenName.setting
                            ? LocaleKeys.forgetPassScreen_changePasswordSubHeading.tr
                            : LocaleKeys.forgetPassScreen_subHeading.tr,
                        color: AppColors.grey60,
                        fontSize: 14,
                        fontWeight: FontWeightType.regular,
                      ),
                    ),
                    gapH16,
                    FormTextField(
                      hintText: LocaleKeys.forgetPassScreen_email.tr,
                      borderRadius: 70,
                      height: 50,
                      readOnly: widget.controller.screenOpenedFrom.value == ScreenName.setting,
                      backgroundColor:
                      widget.controller.screenOpenedFrom.value ==
                          ScreenName.setting
                              ? AppColors.offWhite
                              : AppColors.white,
                      horizontalPadding: 22,
                      verticalPadding: 16,
                      controller: widget.controller.emailTextEditingController,
                      onChanged: (value) {
                        setState(() {
                          widget.controller.isEmailEmpty.value = value.isEmpty;
                        });
                      },
                    ),
                    gapH16,
                    // Obx(() =>
                    RoundBorderButton(
                      color: widget.controller.isEmailEmpty.value
                          ? AppColors.grey90
                          : AppColors.primary,
                      textColor: AppColors.white,
                      title: LocaleKeys.forgetPassScreen_next.tr,
                      onPressed: () async {
                        if (!widget.controller.validateEmailForm(context)) {
                          return;
                        } else {
                          widget.controller.forgotPassword();
                        }
                      },
                    )
                    // ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
