import 'package:doctor_patient_token_mobile_app/app/config/app_icon.dart';
import 'package:doctor_patient_token_mobile_app/presentation/payment/payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/config/app_colors.dart';
import '../../app/services/app_get_view_stateful.dart';
import '../../app/utils/sizes.dart';
import '../../app/config/app_image.dart';
import '../../generated/locales.g.dart';
import '../widgets/button/round_border_button.dart';
import '../widgets/textfield/form_textfield.dart';
import '../widgets/app_text.dart';

class PaymentBottomSheet extends GetStatefulWidget<PaymentController> {
  const PaymentBottomSheet({required this.tokenId, super.key});
  final int tokenId;
  @override
  State<PaymentBottomSheet> createState() => _PaymentBottomSheetState();
}

class _PaymentBottomSheetState extends State<PaymentBottomSheet> {
  @override
  void initState() {
    widget.controller.tokenId = widget.tokenId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: AppIcon.swipe.widget()),
              gapH32,
              AppText.h3(LocaleKeys.paymentScreen_heading.tr,
                  fontWeight: FontWeightType.bold,
                  textAlign: TextAlign.center,
                  fontSize: 26,
                  color: AppColors.black),
              gapH12,
              AppText.primary(
                LocaleKeys.paymentScreen_subHeading.tr,
                color: AppColors.grey60,
              ),
              gapH26,
              _buildPaymentOptions(),
              gapH26,
              FormTextField(
                titleText: widget.controller.selectedPaymentMethod.value ==
                        LocaleKeys.paymentScreen_jazzCash.tr
                    ? LocaleKeys.paymentScreen_EnterJazzCashNo.tr
                    : LocaleKeys.paymentScreen_EnterPayProNo.tr,
                hintText: "03*********",
                borderRadius: 70,
                height: 50,
                horizontalPadding: 22,
                verticalPadding: 16,
                controller: widget.controller.phoneTextEditingController,
              ),
              gapH26,
              const Divider(height: 1, color: AppColors.grey80),
              gapH16,
              AppText.h3(
                LocaleKeys.paymentScreen_info.tr,
                fontWeight: FontWeightType.bold,
                textAlign: TextAlign.center,
                fontSize: 16,
              ),
              gapH8,
              AppText.primary(
                  widget.controller.tokenDetailsEntity.value.patientsList
                          ?.join(', ') ??
                      '',
                  color: AppColors.grey60,
                  fontSize: 14,
                  fontWeight: FontWeightType.regular),
              AppText.primary(
                  "Number of patients: 0${widget.controller.tokenDetailsEntity.value.numberOfPatients.toString()}",
                  color: AppColors.grey60,
                  fontSize: 14,
                  fontWeight: FontWeightType.regular),
              AppText.primary(
                  "Token Number: #${widget.controller.tokenDetailsEntity.value.tokenNumber} • ${widget.controller.tokenDetailsEntity.value.tokenShift}",
                  color: AppColors.grey60,
                  fontSize: 14,
                  fontWeight: FontWeightType.regular),
              gapH16,
              const Divider(height: 1, color: AppColors.grey80),
              gapH26,
              AppText.h3(
                LocaleKeys.paymentScreen_totalPayment.tr +
                    widget.controller.totalAmountToBePaid.value,
                fontWeight: FontWeightType.bold,
                textAlign: TextAlign.center,
                fontSize: 14,
              ),
              gapH26,
              RoundBorderButton(
                title: LocaleKeys.paymentScreen_submit.tr,
                color: AppColors.primary,
                onPressed: () async {
                  widget.controller.validatePayment(context, result: (result) {
                    if (result) {
                      widget.controller.onPaymentSuccess();
                    }
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOptions() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey80, width: 1),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          _buildOption(
            title: LocaleKeys.paymentScreen_jazzCash.tr,
            image: AppImage.jazzCash.widget(),
          ),
          const Divider(height: 1, color: AppColors.grey80),
          _buildOption(
            title: LocaleKeys.paymentScreen_PayPro.tr,
            image: AppImage.payPro.widget(),
          ),
        ],
      ),
    );
  }

  Widget _buildOption({required String title, required Widget image}) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Row(
        children: [
          Expanded(
            child: ListTile(
                title: AppText.primary(title,
                    fontSize: 14,
                    fontWeight: FontWeightType.regular,
                    color: AppColors.black),
                leading: Radio<String>(
                  value: title,
                  groupValue: widget.controller.selectedPaymentMethod.value,
                  activeColor: AppColors.primary,
                  onChanged: (value) {
                    widget.controller.selectedPaymentMethod.value = value!;
                  },
                )),
          ),
          SizedBox(width: 32, height: 32, child: image),
        ],
      ),
    );
  }
}
