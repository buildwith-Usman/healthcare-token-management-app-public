import 'package:doctor_patient_token_mobile_app/app/config/app_image.dart';
import 'package:doctor_patient_token_mobile_app/presentation/start_page/start_controller.dart';
import 'package:doctor_patient_token_mobile_app/presentation/widgets/button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/config/app_colors.dart';
import '../../app/config/app_icon.dart';
import '../../app/utils/sizes.dart';
import '../../generated/locales.g.dart';
import '../widgets/app_text.dart';

class StartPage extends GetView<StartController> {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SingleChildScrollView(
        child: _buildStartPageContent(context),
      ),
    );
  }

  Widget _buildStartPageContent(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderSection(context, screenHeight),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : screenWidth * 0.2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  gapH26,
                  AppText.primary(
                    LocaleKeys.app_name.tr,
                    fontSize: 14,
                    color: AppColors.white,
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                  gapH26,
                  AppText.primary(
                    LocaleKeys.startScreen_drName.tr,
                    fontSize: isMobile ? 28 : 40,
                    fontWeight: FontWeightType.bold,
                    color: AppColors.white,
                  ),
                  AppText.primary(
                    LocaleKeys.startScreen_heading.tr,
                    fontSize: 16,
                    fontWeight: FontWeightType.bold,
                    color: AppColors.white,
                  ),
                  gapH12,
                  AppText.body(
                    LocaleKeys.startScreen_subHeading.tr,
                    fontSize: 15,
                    color: AppColors.white,
                  ),
                  gapH50,
                  PrimaryButton(
                    height: 50,
                    color: AppColors.white,
                    textColor: AppColors.black,
                    title: LocaleKeys.startScreen_getStarted.tr,
                    radius: 10,
                    onPressed: () {
                      controller.goToSignUpScreen();
                    },
                  ),
                  gapH20,
                  Align(
                    alignment: Alignment.center,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          controller.goToLoginScreen();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: AppText.primary(
                            LocaleKeys.startScreen_login.tr,
                            textAlign: TextAlign.center,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  gapH20,
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHeaderSection(BuildContext context, double screenHeight) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: screenHeight / 1.8,
          child: AppImage.startPageImage.widget(fit: BoxFit.fill),
        ),
        Positioned(
          top: 10,
          left: 5,
          child: SizedBox(
            height: 80,
            width: 80,
            child: AppIcon.icAppIcon.widget(),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: 50,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  AppColors.primary.withOpacity(0.9),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
