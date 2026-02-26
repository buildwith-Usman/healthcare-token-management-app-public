import 'package:doctor_patient_token_mobile_app/app/config/app_icon.dart';
import 'package:doctor_patient_token_mobile_app/app/services/app_get_view_stateful.dart';
import 'package:doctor_patient_token_mobile_app/app/utils/sizes.dart';
import 'package:doctor_patient_token_mobile_app/presentation/appointment_confirm/appointment_confirm_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/config/app_colors.dart';
import '../../generated/locales.g.dart';
import '../widgets/app_text.dart';
import '../widgets/button/round_border_button.dart';

class AppointmentConfirmPage
    extends GetStatefulWidget<AppointmentConfirmController> {
  const AppointmentConfirmPage({super.key});

  @override
  State<AppointmentConfirmPage> createState() => _AppointmentConfirmPageState();
}

class _AppointmentConfirmPageState extends State<AppointmentConfirmPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.controller.goToDashboard();
        return false; // Prevent default back navigation
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: _buildPaymentConfirmPageContent(),
        bottomNavigationBar: _buildBottomButton(),
      ),
    );
  }


  Widget _buildPaymentConfirmPageContent() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 35),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppIcon.confirm.widget(width: 50, height: 50),
                gapH20,
                AppText.h3(
                  LocaleKeys.appointmentScreen_heading.tr,
                  fontWeight: FontWeightType.bold,
                  textAlign: TextAlign.center,
                  fontSize: 20,
                ),
                gapH8,
                AppText.primary(
                  textAlign: TextAlign.center,
                  LocaleKeys.appointmentScreen_subHeading.tr,
                  color: AppColors.grey60,
                  fontSize: 14,
                  fontWeight: FontWeightType.regular,
                ),
                gapH40,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText.primary(LocaleKeys.appointmentScreen_tokenNumber.tr,
                        fontWeight: FontWeightType.regular, fontSize: 14),
                    AppText.primary(
                        '#${widget.controller.tokenDetailsEntity.value.tokenNumber?.toString() ?? '0'}',
                        fontWeight: FontWeightType.regular,
                        fontSize: 14),
                  ],
                ),
                gapH16,
                const Divider(
                  height: 1,
                  color: AppColors.grey80,
                ),
                gapH16,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText.primary(
                        LocaleKeys.appointmentScreen_noOfPatients.tr,
                        fontWeight: FontWeightType.regular,
                        fontSize: 14),
                    AppText.primary(
                        widget.controller.tokenDetailsEntity.value
                                .numberOfPatients
                                ?.toString() ??
                            '',
                        fontWeight: FontWeightType.regular,
                        fontSize: 14),
                  ],
                ),
                gapH16,
                const Divider(
                  height: 1,
                  color: AppColors.grey80,
                ),
                ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.controller.tokenDetailsEntity.value
                          .patientsList?.length ??
                      0,
                  itemBuilder: (context, index) {
                    final patientName = widget.controller.tokenDetailsEntity
                            .value.patientsList?[index].patientName ??
                        'Unknown';
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      margin: EdgeInsets.zero, // removes spacing between tiles
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText.primary(
                            'Patient ${index + 1}',
                            fontWeight: FontWeightType.regular,
                            fontSize: 14,
                          ),
                          AppText.primary(
                            patientName,
                            fontWeight: FontWeightType.regular,
                            fontSize: 14,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const Divider(
                  height: 1,
                  color: AppColors.grey80,
                ),
                gapH16,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText.primary(
                        LocaleKeys.appointmentScreen_dateAndTime.tr),
                    AppText.primary(
                        '${widget.controller.tokenDetailsEntity.value.tokenBookedDate} / ${widget.controller.tokenDetailsEntity.value.tokenShift}',
                        fontWeight: FontWeightType.regular,
                        fontSize: 14),
                  ],
                ),
                gapH16,
                const Divider(
                  height: 1,
                  color: AppColors.grey80,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: RoundBorderButton(
        color: AppColors.primary,
        textColor: AppColors.white,
        title: LocaleKeys.appointmentScreen_backToDashBoard.tr,
        onPressed: () {
          widget.controller.goToDashboard();
        },

      ),
    );
  }
}
