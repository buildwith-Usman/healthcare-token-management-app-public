import 'package:doctor_patient_token_mobile_app/app/services/app_get_view_stateful.dart';
import 'package:doctor_patient_token_mobile_app/generated/locales.g.dart';
import 'package:doctor_patient_token_mobile_app/presentation/congratulation/congo_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/config/app_colors.dart';
import '../../app/config/app_enum.dart';
import '../../app/config/app_image.dart';
import '../../app/utils/sizes.dart';
import '../widgets/app_text.dart';
import '../widgets/button/round_border_button.dart';

class CongoPage extends GetStatefulWidget<CongoController> {
  const CongoPage({super.key});

  @override
  State<CongoPage> createState() => _CongoPageState();
}

class _CongoPageState extends State<CongoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: _buildCongoPageContent(),
      bottomNavigationBar: _buildBottomButton(),
    );
  }

  Widget _buildBottomButton() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 40),
      child: RoundBorderButton(
        color: AppColors.primary,
        textColor: AppColors.white,
        title: LocaleKeys.congoScreen_backToLogin.tr,
        onPressed: () {
          widget.controller.goToLogin();
        },
      ),
    );
  }

  Widget _buildCongoPageContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(child: AppImage.congo.widget()),
        gapH30,
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Obx(() => AppText.h3(
                  widget.controller.screenOpenedFrom.value ==
                          ScreenName.signUp.toString()
                      ? "Congratulations!\nAccount is created"
                      : "Congratulations!\nNew password has been set",
                  fontWeight: FontWeightType.bold,
                  textAlign: TextAlign.center,
                  fontSize: 26,
                ))),
        gapH14,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: AppText.primary(
            textAlign: TextAlign.center,
            LocaleKeys.congoScreen_subHeading.tr,
            color: AppColors.grey60,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
