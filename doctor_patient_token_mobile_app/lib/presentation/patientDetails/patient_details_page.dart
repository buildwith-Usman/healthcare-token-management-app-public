import 'package:doctor_patient_token_mobile_app/app/config/app_colors.dart';
import 'package:doctor_patient_token_mobile_app/app/services/app_get_view_stateful.dart';
import 'package:doctor_patient_token_mobile_app/app/utils/sizes.dart';
import 'package:doctor_patient_token_mobile_app/app/utils/string_extension.dart';
import 'package:doctor_patient_token_mobile_app/presentation/patientDetails/patient_details_controller.dart';
import 'package:doctor_patient_token_mobile_app/presentation/widgets/app_text.dart';
import 'package:doctor_patient_token_mobile_app/presentation/widgets/button/round_border_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/config/app_icon.dart';
import '../../app/utils/util.dart';
import '../../generated/locales.g.dart';

class PatientDetailsPage extends GetStatefulWidget<PatientDetailsController> {
  const PatientDetailsPage({super.key});

  @override
  State<PatientDetailsPage> createState() => _PatientDetailsPageState();
}

class _PatientDetailsPageState extends State<PatientDetailsPage> {
  final List<String> tabs = ["All", "Morning", "Evening"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: _buildDashboardContent(),
    );
  }

  Widget _buildDashboardContent() {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Row(
              children: [
                InkWell(
                  child: AppIcon.leftArrowIcon.widget(height: 24, width: 24),
                  onTap: () {
                    Get.back();
                  },
                ),
                Expanded(
                  child: Center(
                    child: AppText.primary('User Profile',fontWeight: FontWeightType.semiBold,),
                  ),
                ),
                gapW24,
              ],
            ),
          ),
          Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBigCircle(Util.getInitials(
                      widget.controller.currentUserName.value)),
                  gapH16,
                  AppText.primary(widget.controller.currentUserName.value,
                      fontSize: 34, fontWeight: FontWeightType.semiBold),
                  gapH16,
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.offWhite,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.offWhite,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: List.generate(tabs.length, (index) {
                        final selected =
                            widget.controller.selectedTabIndex.value == index;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () => widget.controller.changeTab(index),
                            child: Container(
                              height: 34,
                              decoration: BoxDecoration(
                                color: selected
                                    ? AppColors.primary
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: AppText.primary(tabs[index],
                                    fontSize: 14,
                                    color: selected
                                        ? AppColors.white
                                        : AppColors.black,
                                    fontWeight: FontWeightType.semiBold),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
          gapH16,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: AppText.primary(
              "Appointment History",
              fontWeight: FontWeightType.bold,
              fontSize: 16,
              color: AppColors.black,
            ),
          ),
          gapH20,
          Expanded(
            child: Obx(() {
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: widget.controller.appointmentsHistory.length,
                  itemBuilder: (context, index) {
                    final appointments = widget.controller.appointmentsHistory;
                    return GestureDetector(
                      onTap: () {
                        widget.controller.navigateToTokenDetails(
                          appointments[index].tokenId ?? 0,
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Date and Time
                          AppText.primary(
                            "${appointments[index].shift?.capitalizeFirstLetter()} / ${appointments[index].date?.toFormattedDate()}",
                            fontSize: 14,
                            color: AppColors.darkGrey,
                          ),
                          gapH16,
                          // First Row (Avatar + Name + Token Details)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Avatar container
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(70),
                                  color: AppColors.lightGrey,
                                ),
                                child: Center(
                                  child: AppText.primary(
                                    (appointments[index].name ??
                                            "Ikram Medical")
                                        .getInitials(),
                                    fontWeight: FontWeightType.medium,
                                    fontSize: 16,
                                    color: AppColors.grey60,
                                  ),
                                ),
                              ),
                              gapW10,
                              // Column for Name + Date + Token
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AppText.primary(
                                      appointments[index].name ??
                                          "Ikram Medical",
                                      color: AppColors.black,
                                      fontWeight: FontWeightType.medium,
                                      fontSize: 16,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        // LEFT SIDE — use Flexible to avoid pushing the row
                                        Flexible(
                                          child: AppText.primary(
                                            "${(appointments[index].date)?.toFormattedDateWithSlash()} • TN (#${appointments[index].tokenNumber}) - ${appointments[index].numberOfPatients} Patient",
                                            fontSize: 12,
                                            fontWeight: FontWeightType.regular,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left:
                                                  8.0), // slight space between
                                          child: IntrinsicWidth(
                                            child: RoundBorderButton(
                                              height: 18,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 14.0),
                                              color:
                                                  appointments[index].status ==
                                                          "pending"
                                                      ? AppColors.pendingColor
                                                      : AppColors.checkedColor,
                                              textColor: AppColors.white,
                                              title: appointments[index]
                                                          .status ==
                                                      "pending"
                                                  ? LocaleKeys
                                                      .receptionDashboardScreen_pending
                                                      .tr
                                                  : LocaleKeys
                                                      .receptionDashboardScreen_checked
                                                      .tr,
                                              fontSize: 12,
                                              onPressed: () {},
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return gapH16;
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildBigCircle(String initials) {
    return Container(
      height: 80,
      width: 80,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.offWhite,
      ),
      child: Center(
        child: AppText.primary(
          initials,
          fontSize: 32,
          color: AppColors.grey60,
          fontWeight: FontWeightType.bold,
        ),
      ),
    );
  }
}
