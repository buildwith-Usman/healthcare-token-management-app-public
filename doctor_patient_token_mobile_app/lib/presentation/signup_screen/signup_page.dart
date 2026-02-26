import 'package:doctor_patient_token_mobile_app/presentation/signup_screen/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/config/app_colors.dart';
import '../../app/config/app_icon.dart';
import '../../app/config/app_image.dart';
import '../../app/services/app_get_view_stateful.dart';
import '../../app/utils/sizes.dart';
import '../../generated/locales.g.dart';
import '../widgets/app_text.dart';
import '../widgets/button/round_border_button.dart';
import '../widgets/textfield/form_textfield.dart';

class SignupPage extends GetStatefulWidget<SignupController> {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: _buildSignupPageContent(),
    );
  }

  Widget _buildSignupPageContent() {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final screenHeight = constraints.maxHeight;
          final screenWidth = constraints.maxWidth;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  gapH20,
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          child: AppIcon.leftArrowIcon
                              .widget(height: 24, width: 24),
                          onTap: () {
                            widget.controller.goToPreviousScreen();
                          },
                        ),
                      ),
                      Center(child: AppImage.startLogoImage.widget()),
                    ],
                  ),
                  gapH54,
                  AppText.h3(
                    LocaleKeys.signupScreen_heading.tr,
                    fontWeight: FontWeightType.bold,
                    textAlign: TextAlign.center,
                    fontSize: 26,
                  ),
                  gapH16,
                  AppText.primary(
                    LocaleKeys.signupScreen_subHeading.tr,
                    color: AppColors.grey60,
                    textAlign: TextAlign.center,
                    fontSize: 14,
                    fontWeight: FontWeightType.regular,
                  ),
                  gapH20,
                  FormTextField(
                    hintText: LocaleKeys.signupScreen_name.tr,
                    borderRadius: 70,
                    height: 50,
                    horizontalPadding: 22,
                    verticalPadding: 16,
                    controller: widget.controller.nameTextEditingController,
                  ),
                  FormTextField(
                    hintText: LocaleKeys.signupScreen_email.tr,
                    borderRadius: 70,
                    height: 50,
                    horizontalPadding: 22,
                    verticalPadding: 16,
                    controller: widget.controller.emailTextEditingController,
                  ),
                  FormTextField(
                    hintText: LocaleKeys.signupScreen_mobilNo.tr,
                    borderRadius: 70,
                    height: 50,
                    horizontalPadding: 22,
                    verticalPadding: 16,
                    controller: widget.controller.mobileTextEditingController,
                  ),
                  gapH20,
                  RoundBorderButton(
                    color: AppColors.primary,
                    textColor: AppColors.white,
                    title: LocaleKeys.signupScreen_next.tr,
                    onPressed: () async {
                      if (!widget.controller.validateSignUpForm(context)) {
                        return;
                      } else {
                        await widget.controller.signUp();
                      }
                    },
                  ),
                  gapH24,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText.primary(
                        LocaleKeys.signupScreen_alreadyHaveAccount.tr,
                        fontSize: 14,
                        fontWeight: FontWeightType.regular,
                      ),
                      gapW4,
                      InkWell(
                        onTap: () => Get.back(),
                        child: AppText.primary(
                          LocaleKeys.signupScreen_login.tr,
                          color: AppColors.linkBlue,
                          fontWeight: FontWeightType.semiBold,
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
