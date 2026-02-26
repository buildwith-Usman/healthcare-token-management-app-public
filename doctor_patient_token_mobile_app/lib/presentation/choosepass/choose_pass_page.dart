import 'package:doctor_patient_token_mobile_app/presentation/choosepass/choose_pass_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/config/app_colors.dart';
import '../../app/config/app_icon.dart';
import '../../app/services/app_get_view_stateful.dart';
import '../../app/utils/sizes.dart';
import '../../gen/assets.gen.dart';
import '../../generated/locales.g.dart';
import '../widgets/app_text.dart';
import '../widgets/button/round_border_button.dart';
import '../widgets/textfield/form_textfield.dart';

class ChoosePassPage extends GetStatefulWidget<ChoosePassController> {
  const ChoosePassPage({super.key});

  @override
  State<ChoosePassPage> createState() => _ChoosePassPage();
}

class _ChoosePassPage extends State<ChoosePassPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: _buildChosePassPageContent(),
    );
  }

  Widget _buildChosePassPageContent() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                LocaleKeys.chosePassScreen_heading.tr,
                fontWeight: FontWeightType.bold,
                textAlign: TextAlign.center,
                fontSize: 26,
              ),
              gapH16,
              AppText.primary(
                LocaleKeys.chosePassScreen_subHeading.tr,
                color: AppColors.grey60,
                textAlign: TextAlign.center,
                fontSize: 14,
                fontWeight: FontWeightType.regular,
              ),
              gapH20,
              FormTextField(
                hintText:LocaleKeys.chosePassScreen_newPassword.tr,
                borderRadius: 70,
                height: 50,
                horizontalPadding: 22,
                verticalPadding: 16,
                isPasswordField: true,
                controller: widget.controller.passwordTextEditingController,
                onChanged: (value) {
                  setState(() {
                    widget.controller.isEmailEmpty.value = value.isEmpty;
                  });
                },
              ),
              gapH16,
              Obx(() => RoundBorderButton(
                color: widget.controller.isEmailEmpty.value
                    ? AppColors.grey90
                    : AppColors.primary,
                textColor: AppColors.white,
                title: LocaleKeys.chosePassScreen_submit.tr,
                onPressed: () async {
                  if (!widget.controller.validatePassword(context)) {
                    return;
                  } else {
                    await widget.controller.createPassword();
                  }
                },
              )),
            ],
          ),
        ),
      ),
    );
  }

}
