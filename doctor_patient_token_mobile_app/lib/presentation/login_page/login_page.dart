import 'package:doctor_patient_token_mobile_app/app/config/app_colors.dart';
import 'package:doctor_patient_token_mobile_app/app/config/app_image.dart';
import 'package:doctor_patient_token_mobile_app/generated/locales.g.dart';
import 'package:doctor_patient_token_mobile_app/presentation/widgets/app_text.dart';
import 'package:doctor_patient_token_mobile_app/presentation/widgets/button/primary_button.dart';
import 'package:doctor_patient_token_mobile_app/presentation/widgets/button/round_border_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/config/app_icon.dart';
import '../../app/services/app_get_view_stateful.dart';
import '../../app/utils/sizes.dart';
import '../widgets/app_button.dart';
import '../widgets/textfield/form_textfield.dart';
import 'login_controller.dart';

class LoginPage extends GetStatefulWidget<LoginController> {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: _buildLoginPageContent(context),
    );
  }

  Widget _buildLoginPageContent(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final screenHeight = constraints.maxHeight;
          final screenWidth = constraints.maxWidth;
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  gapH16,
                  Center(child: AppImage.startLogoImage.widget()),
                  gapH60,
                  AppText.h3(
                    LocaleKeys.loginScreen_heading.tr,
                    fontWeight: FontWeightType.bold,
                    textAlign: TextAlign.center,
                  ),
                  gapH18,
                  AppText.primary(
                    LocaleKeys.loginScreen_subHeading.tr,
                    color: AppColors.grey60,
                    textAlign: TextAlign.center,
                  ),
                  gapH28,
                  FormTextField(
                    hintText: LocaleKeys.loginScreen_enterEmail.tr,
                    borderRadius: 70,
                    height: 50,
                    horizontalPadding: 22,
                    verticalPadding: 16,
                    controller: widget.controller.emailTextEditingController,
                    onChanged: (value) {
                      setState(() {
                        widget.controller.isEmailEmpty.value = value.isEmpty;
                      });
                    },
                  ),
                  Obx(
                    () => widget.controller.isEmailEmpty.value
                        ? const SizedBox()
                        : FormTextField(
                            hintText: LocaleKeys.loginScreen_enterPass.tr,
                            borderRadius: 70,
                            height: 50,
                            horizontalPadding: 22,
                            verticalPadding: 16,
                            isPasswordField: true,
                            controller:
                                widget.controller.passwordTextEditingController,
                            onChanged: (value) {},
                          ),
                  ),
                  gapH16,
                  Obx(
                    () => RoundBorderButton(
                      color: widget.controller.isEmailEmpty.value
                          ? AppColors.grey90
                          : AppColors.primary,
                      textColor: AppColors.white,
                      title: LocaleKeys.loginScreen_login.tr,
                      height: 50,
                      radius: 70,
                      fontSize: 14,
                      fontWeight: FontWeightType.medium,
                      onPressed: () async {
                        if (!widget.controller.validateLoginForm(context)) {
                          return;
                        } else {
                          widget.controller.login();
                        }
                      },
                    ),
                  ),
                  gapH20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText.primary(
                        LocaleKeys.loginScreen_doNotHaveAccount.tr,
                        fontSize: 14,
                        fontWeight: FontWeightType.regular,
                        color: AppColors.lightBlack,
                      ),
                      gapW4,
                      InkWell(
                        child: AppText.primary(
                          LocaleKeys.loginScreen_signUp.tr,
                          color: AppColors.linkBlue,
                          fontWeight: FontWeightType.semiBold,
                          decoration: TextDecoration.underline,
                        ),
                        onTap: () {
                          widget.controller.goToSignUpScreen();
                        },
                      ),
                    ],
                  ),
                  gapH20,
                  InkWell(
                    child: AppText.primary(
                      LocaleKeys.signupScreen_forgetPass.tr,
                      color: AppColors.grey50,
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
                      widget.controller.goToForgetPasswordScreen();
                    },
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  // PrimaryButton(
                  //     title: 'Login with Google',
                  //     height: 50,
                  //     color: Colors.transparent,
                  //     // borderColor: AppColors.grey80,
                  //     radius: 70,
                  //     fontWeight: FontWeightType.regular,
                  //     textColor: AppColors.black,
                  //     // icon: AppIcon.googleButton.widget(),
                  //     onPressed: () async {
                  //         widget.controller.loginWithGoogle();
                  //     }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
