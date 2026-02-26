import 'package:doctor_patient_token_mobile_app/app/config/app_enum.dart';
import 'package:doctor_patient_token_mobile_app/app/services/app_get_view_stateful.dart';
import 'package:doctor_patient_token_mobile_app/generated/locales.g.dart';
import 'package:doctor_patient_token_mobile_app/presentation/otp/otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../app/config/app_colors.dart';
import '../../app/config/app_icon.dart';
import '../../app/utils/sizes.dart';
import '../../gen/assets.gen.dart';
import '../widgets/app_text.dart';

class OtpPage extends GetStatefulWidget<OtpController> {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: _buildOtpPageContent(context),
    );
  }

  Widget _buildOtpPageContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      child: Column(
        children: [
          Stack(
            children: [
              Positioned(
                bottom: 0,
                top: 0,
                left: 0,
                child: InkWell(
                  child: AppIcon.leftArrowIcon.widget(height: 24, width: 24),
                  onTap: () {
                    widget.controller.goToPreviousScreen();
                  },
                ),
              ),
              Center(child: Assets.images.logo.image()),
            ],
          ),
          gapH50,
          AppText.h3(
            LocaleKeys.otpScreen_verificationEmail.tr,
            fontWeight: FontWeightType.bold,
            textAlign: TextAlign.center,
            fontSize: 30,
          ),
          gapH8,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: AppText.primary(
              textAlign: TextAlign.center,
              LocaleKeys.otpScreen_verificationEmailSubHeading.tr,
              color: AppColors.grey60,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 28),
            child: PinCodeTextField(
              appContext: context,
              length: 6,
              obscureText: false,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderWidth: 1,
                activeBorderWidth: 1,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                fieldHeight: 52,
                fieldWidth: 48,
                activeFillColor: AppColors.white,
                inactiveFillColor: AppColors.grey97,
                selectedFillColor: AppColors.blueShade50,
                activeColor: AppColors.black,
                selectedColor: AppColors.primary,
                inactiveColor: AppColors.grey90,
              ),
              keyboardType: TextInputType.number,
              controller: widget.controller.verificationCodeController,
              onCompleted: (value) async {
                await widget.controller.otpVerification();
              },
            ),
          ),
          gapH6,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText.primary(
                LocaleKeys.otpScreen_doNotReceiveOtp.tr,
                fontSize: 14,
              ),
              gapW4,
              InkWell(
                child: AppText.primary(
                  LocaleKeys.otpScreen_resendOtp.tr,
                  color: AppColors.linkBlue,
                  fontWeight: FontWeightType.semiBold,
                  decoration: TextDecoration.underline,
                  fontSize: 14,
                ),
                onTap: () async {
                  widget.controller.resendOTP();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  String getScreenTitle(ScreenName screen) {
    switch (screen) {
      case ScreenName.signUp:
        return LocaleKeys.otpScreen_verifyPassword.tr;
      case ScreenName.login:
        return LocaleKeys.otpScreen_forgetPassword.tr;
      case ScreenName.setting:
        return LocaleKeys.otpScreen_verificationEmail.tr;
      default:
        return '';
    }
  }

  String getScreenSubheading(ScreenName screen) {
    if (screen == ScreenName.setting) {
      return LocaleKeys.otpScreen_verificationEmailSubHeading.tr;
    } else {
      return LocaleKeys.otpScreen_subHeading.tr;
    }
  }
}
