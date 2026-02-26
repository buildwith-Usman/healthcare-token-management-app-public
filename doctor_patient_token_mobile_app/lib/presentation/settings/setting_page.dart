import 'package:doctor_patient_token_mobile_app/app/config/app_enum.dart';
import 'package:doctor_patient_token_mobile_app/app/services/app_get_view_stateful.dart';
import 'package:doctor_patient_token_mobile_app/app/utils/sizes.dart';
import 'package:doctor_patient_token_mobile_app/app/utils/string_extension.dart';
import 'package:doctor_patient_token_mobile_app/generated/locales.g.dart';
import 'package:doctor_patient_token_mobile_app/presentation/settings/change_profile_binding.dart';
import 'package:doctor_patient_token_mobile_app/presentation/settings/change_profile_bottom_sheet.dart';
import 'package:doctor_patient_token_mobile_app/presentation/settings/setting_controller.dart';
import 'package:doctor_patient_token_mobile_app/presentation/time_update_bottom_sheet/time_update_bottom_sheet.dart';
import 'package:doctor_patient_token_mobile_app/presentation/time_update_bottom_sheet/time_update_bottom_sheet_binding.dart';
import 'package:doctor_patient_token_mobile_app/presentation/widgets/app_text.dart';
import 'package:flutter/material.dart';

import '../../app/config/app_colors.dart';
import 'package:get/get.dart';

import '../../app/config/app_icon.dart';
import '../../app/services/app_storage.dart';
import '../navigation/nav_controller.dart';

class SettingPage extends GetStatefulWidget<SettingController> {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final NavController navController = Get.find();
  UserRole? userRole = AppStorage.instance.userRole;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.settingScreenBgColor,
      body: _buildSettingContent(),
    );
  }

  Widget _buildSettingContent() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      top: 0,
                      left: 0,
                      child: InkWell(
                        child:
                            AppIcon.leftArrowIcon.widget(height: 24, width: 24),
                        onTap: () {
                          navController.changeTab(0);
                        },
                      ),
                    ),
                    Center(
                        child: AppText.h3(
                      LocaleKeys.settingScreen_title.tr,
                      fontWeight: FontWeightType.bold,
                      textAlign: TextAlign.center,
                      fontSize: 16,
                    )),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 14,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(70),
                          color: AppColors.primary,
                        ),
                        child: Center(
                          child: AppText.primary(
                            widget.controller.userName.value.getInitials(),
                            fontWeight: FontWeightType.medium,
                            fontSize: 16,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      gapW10,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppText.primary(
                              widget.controller.userName.value,
                              color: AppColors.black,
                              fontWeight: FontWeightType.medium,
                              fontSize: 16,
                            ),
                            AppText.primary(
                              widget.controller.userEmail.value,
                              fontSize: 12,
                              fontWeight: FontWeightType.regular,
                              color: AppColors.darkGrey,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (userRole == UserRole.doctor) ...[
                  GestureDetector(
                    onTap: (){
                      showTimeUpdateBottomSheet(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 14,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(70),
                              color:
                                  AppColors.settingScreenDrAppointmentLabelColor,
                            ),
                            child: Center(
                              child: AppIcon.navBookAppointment
                                  .widget(color: AppColors.white),
                            ),
                          ),
                          gapW10,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppText.primary(
                                  LocaleKeys.settingScreen_appointmentSettings.tr,
                                  color: AppColors.black,
                                  fontWeight: FontWeightType.medium,
                                  fontSize: 16,
                                ),
                                AppText.primary(
                                  widget.controller.userEmail.value,
                                  fontSize: 12,
                                  fontWeight: FontWeightType.regular,
                                  color: AppColors.darkGrey,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                gapH22,
                AppText.primary(
                  LocaleKeys.settingScreen_settings.tr,
                  fontWeight: FontWeightType.medium,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 14,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        child: Row(
                          children: [
                            // Circle with phone icon
                            Container(
                              height: 30,
                              width: 30,
                              alignment: Alignment.center, // Center the child
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.phone,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                            gapW10,
                            Expanded(
                              child: AppText.primary(
                                LocaleKeys.settingScreen_changeEmail.tr,
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            AppIcon.rightArrowIcon
                                .widget(height: 24, width: 24),
                          ],
                        ),
                        onTap: () {
                          showChangeProfileBottomSheet(context,BottomSheetType.changeEmail);
                        },
                      ),
                      gapH14,
                      InkWell(
                        child: Row(
                          children: [
                            // Circle with phone icon
                            Container(
                              height: 30,
                              width: 30,
                              alignment: Alignment.center, // Center the child
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.phone,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                            gapW10,
                            Expanded(
                              child: AppText.primary(
                                LocaleKeys.settingScreen_changeMobileNo.tr,
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            AppIcon.rightArrowIcon
                                .widget(height: 24, width: 24),
                          ],
                        ),
                        onTap: () {
                          showChangeProfileBottomSheet(context,BottomSheetType.changePhone);
                        },
                      ),
                      gapH14,
                      InkWell(
                        child: Row(
                          children: [
                            // Circle with phone icon
                            Container(
                              height: 30,
                              width: 30,
                              alignment: Alignment.center, // Center the child
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.phone,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                            gapW10,
                            Expanded(
                              child: AppText.primary(
                                LocaleKeys.settingScreen_changePass.tr,
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            AppIcon.rightArrowIcon
                                .widget(height: 24, width: 24),
                          ],
                        ),
                        onTap: () {
                          widget.controller.goToChangePasswordScreen();
                        },
                      ),
                    ],
                  ),
                ),
                gapH30,
                AppText.primary(
                  "About This App",
                  fontWeight: FontWeightType.medium,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 14,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Version
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText.primary(
                            "Version:",
                            fontSize: 14,
                            fontWeight: FontWeightType.medium,
                            color: AppColors.black,
                          ),
                          AppText.primary(
                            "1.0.0",
                            fontSize: 14,
                            fontWeight: FontWeightType.regular,
                            color: AppColors.darkGrey,
                          ),
                        ],
                      ),
                      gapH14,
                      const Divider(height: 1, color: AppColors.lightGrey),
                      gapH14,
                      // Directed by
                      AppText.primary(
                        "Directed by:",
                        fontSize: 14,
                        fontWeight: FontWeightType.medium,
                        color: AppColors.black,
                      ),
                      gapH4,
                      AppText.primary(
                        "Umar Maqsood",
                        fontSize: 14,
                        fontWeight: FontWeightType.regular,
                        color: AppColors.darkGrey,
                      ),
                      gapH14,
                      // Backend Developer
                      AppText.primary(
                        "Backend Developer:",
                        fontSize: 14,
                        fontWeight: FontWeightType.medium,
                        color: AppColors.black,
                      ),
                      gapH4,
                      AppText.primary(
                        "Umair Maqsood",
                        fontSize: 14,
                        fontWeight: FontWeightType.regular,
                        color: AppColors.darkGrey,
                      ),
                      gapH14,
                      // Mobile Developer
                      AppText.primary(
                        "Mobile Developer:",
                        fontSize: 14,
                        fontWeight: FontWeightType.medium,
                        color: AppColors.black,
                      ),
                      gapH4,
                      AppText.primary(
                        "Muhammad Usman",
                        fontSize: 14,
                        fontWeight: FontWeightType.regular,
                        color: AppColors.darkGrey,
                      ),
                      gapH20,
                      const Divider(height: 1, color: AppColors.lightGrey),
                      gapH14,
                      // Copyright
                      Center(
                        child: AppText.primary(
                          "© 2025 All Rights Reserved",
                          fontSize: 12,
                          fontWeight: FontWeightType.regular,
                          color: AppColors.darkGrey,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                gapH20,
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 20, 10),
                    child: AppText.primary(
                      LocaleKeys.settingScreen_logout.tr,
                      color: AppColors.black,
                      fontSize: 16,
                      fontWeight: FontWeightType.semiBold,
                    ),
                  ),
                  onTap: () {
                    widget.controller.clearStorageAndNavigateToStartScreen();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showChangeProfileBottomSheet(
      BuildContext context, BottomSheetType type) {
    final navController = Get.find<NavController>();
    ChangeProfileBinding().dependencies();
    navController.shouldShowNavBar.value = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ChangeProfileBottomSheet(type: type),
    ).whenComplete(() {
      navController.shouldShowNavBar.value = true;
    });
  }

  void showTimeUpdateBottomSheet(
      BuildContext context) {
    final navController = Get.find<NavController>();
    TimeUpdateBottomSheetBinding().dependencies();
    navController.shouldShowNavBar.value = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const TimeUpdateBottomSheet(),
    ).whenComplete(() {
      navController.shouldShowNavBar.value = true;
    });
  }

}
