import 'package:doctor_patient_token_mobile_app/app/config/app_icon.dart';
import 'package:doctor_patient_token_mobile_app/app/config/app_image.dart';
import 'package:doctor_patient_token_mobile_app/app/services/app_get_view_stateful.dart';
import 'package:doctor_patient_token_mobile_app/app/utils/app_extensions.dart';
import 'package:doctor_patient_token_mobile_app/app/utils/string_extension.dart';
import 'package:doctor_patient_token_mobile_app/app/utils/util.dart';
import 'package:doctor_patient_token_mobile_app/presentation/patient_dashboard/patient_dashboard_controller.dart';
import 'package:doctor_patient_token_mobile_app/presentation/widgets/app_text.dart';
import 'package:doctor_patient_token_mobile_app/presentation/widgets/textfield/search_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/config/app_colors.dart';
import '../../app/config/app_enum.dart';
import '../../app/utils/sizes.dart';
import '../../generated/locales.g.dart';
import '../doctor_dashboard/filter_bottom_sheet.dart';
import '../doctor_dashboard/filter_bottom_sheet_binding.dart';
import '../navigation/nav_controller.dart';
import '../widgets/button/round_border_button.dart';

typedef OnFilterSubmit = void Function(
    DateTime selectedDate, String selectedShift);

class PatientDashboardPage
    extends GetStatefulWidget<PatientDashboardController> {
  const PatientDashboardPage({super.key});

  @override
  State<PatientDashboardPage> createState() => _PatientDashboardPageState();
}

class _PatientDashboardPageState extends State<PatientDashboardPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Add scroll listener for pagination
    _scrollController.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ever<String>(widget.controller.errorMessage, (msg) {
        if (msg.isNotEmpty) {
          Util.showErrorToast(
            message: msg,
            context: context,
          );
        }
      });
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      // Load more when user is 200 pixels from bottom
      widget.controller.loadMoreAppointments();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final NavController navController = Get.find();
    return Scaffold(
      backgroundColor: AppColors.white,
      body: _buildDashboardContent(navController),
      bottomNavigationBar:
          widget.controller.userRole.value == UserRole.reception
              ? _buildBottomNav(navController)
              : null,
    );
  }

  Widget _buildDashboardContent(
    NavController navController,
  ) {
    return SafeArea(
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Obx(() {
              final message =
                  widget.controller.currentShiftEntity.value.message;
              if (message != null && message.isNotEmpty) {
                return Container(
                  width: double.infinity,
                  color: AppColors.red513,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: AppText.primary(
                    message,
                    textAlign: TextAlign.center,
                    color: AppColors.white,
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() => AppText.primary(
                                '${LocaleKeys.patientDashboardScreen_welcome.tr} ${widget.controller.currentUserName.value}',
                                fontSize: 14,
                                fontWeight: FontWeightType.medium,
                              )),
                          Row(
                            children: [
                              if (widget.controller.userRole.value ==
                                  UserRole.reception) ...[
                                InkWell(
                                    onTap: () {
                                      showFilterBottomSheet(context,
                                          (selectedDate, selectedShift) {
                                        widget.controller.currentShiftEntity
                                            .value.shift = selectedShift;
                                        widget.controller.currentShiftEntity
                                                .value.date =
                                            selectedDate.dateToStringWithFormat(
                                                format: "yyyy-MM-dd");
                                        widget.controller
                                            .getAppointmentHistory();
                                      });
                                    },
                                    child: AppIcon.filter.widget()),
                                gapW20,
                                // AppIcon.notification.widget(),
                                // gapW20,
                              ],
                              // Profile Avatar (always shown)
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(70),
                                  color: AppColors.primary,
                                ),
                                child: Center(
                                  child: AppText.primary(
                                    widget.controller.currentUserName.value
                                        .getInitials(),
                                    fontWeight: FontWeightType.medium,
                                    fontSize: 16,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Obx(() {
                    if (widget.controller.userRole.value ==
                            UserRole.reception &&
                        widget.controller.hideReceptionAppointmentDetailsLayout
                            .value) {
                      return Column(
                        children: [
                          gapH10,
                          RoundBorderButton(
                            height: 34,
                            color:
                                AppColors.receptionCurrentTokenBorderWidthColor,
                            textColor: AppColors.black,
                            title:
                                '(#${widget.controller.currentTokenNumber.value}) Current Token Number',
                            fontSize: 14,
                            fontWeight: FontWeightType.semiBold,
                            radius: 60,
                            borderWidthColor: AppColors.receptionCurrentTokenBg,
                            borderWidth: 1,
                            onPressed: () {},
                          ),
                          gapH10,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: _buildReceptionAppointmentsCard(
                                  title:
                                      widget.controller.totalAppointments.value,
                                  subtitle: LocaleKeys
                                      .receptionDashboardScreen_appointment.tr,
                                  dateInfo:
                                      "${widget.controller.currentShiftEntity.value.date?.toFormattedDate()} - Friday\n${widget.controller.currentShiftEntity.value.shift?.capitalizeFirstLetter()}",
                                  backgroundColor:
                                      AppColors.appointmentBoxColor,
                                  isActive: true,
                                ),
                              ),
                              gapW8,
                              Expanded(
                                child: _buildReceptionAppointmentsCard(
                                  title: "Waiting",
                                  subtitle: widget.controller.currentShiftEntity
                                              .value.shift ==
                                          "morning"
                                      ? "Start 8:30 AM"
                                      : "Start 6:00 PM",
                                  dateInfo:
                                      "${widget.controller.currentShiftEntity.value.date?.toFormattedDate()} - Friday\n${widget.controller.currentShiftEntity.value.shift?.capitalizeFirstLetter()}",
                                  titleFontSize: 30,
                                  textColor: AppColors.grey60,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox
                          .shrink(); // empty widget when condition doesn't match
                    }
                  }),
                  if (widget.controller.userRole.value == UserRole.patient) ...[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => AppText.h6(
                            widget.controller.currentTokenNumber.value
                                .toString(),
                            fontSize: 100,
                            fontWeight: FontWeightType.bold)),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 4, bottom: 0),
                          child:
                              AppImage.tokenImage.widget(width: 30, height: 30),
                        ),
                      ],
                    ),
                    AppText.primary(
                      LocaleKeys.patientDashboardScreen_currentToken.tr,
                      fontWeight: FontWeightType.bold,
                      fontSize: 14,
                    ),
                    gapH10,
                    Obx(
                      () => IntrinsicWidth(
                        child: RoundBorderButton(
                          height: 28,
                          radius: 50,
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          width: double.infinity, // still stretch inside
                          color: widget.controller.bookingEnabled.value
                              ? AppColors.primary
                              : AppColors.bookedTokenBgColor,
                          textColor: widget.controller.bookingEnabled.value
                              ? AppColors.white
                              : AppColors.bookedTokenBoxTextColor,
                          fontSize: 14,
                          title: LocaleKeys
                              .patientDashboardScreen_bookAppointment.tr,
                          onPressed: () {
                            if (!widget.controller.bookingEnabled.value) {
                              navController.changeTab(1);
                            } else {
                              Util.showErrorToast(
                                message: widget.controller.currentShiftEntity
                                    .value.message!,
                                context: context,
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    Obx(() {
                      final userTokenNumber = widget
                          .controller.currentShiftEntity.value.userTokenNumber;
                      if (userTokenNumber != null &&
                          userTokenNumber.isNotEmpty) {
                        return IntrinsicWidth(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: RoundBorderButton(
                              height: 28,
                              radius: 50,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 22),
                              width: double.infinity, // still stretch inside
                              color: AppColors.primary,
                              textColor: AppColors.white,
                              fontSize: 14,
                              title:
                                  "Your Token # ${widget.controller.currentShiftEntity.value.userTokenNumber ?? 'N/A'}",
                              onPressed: () {
                                // Nothing to do, just for layout purpose
                              },
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox
                            .shrink(); // empty widget when condition doesn't match
                      }
                    }),
                  ],
                  gapH22,
                  SearchTextField(
                    height: 50,
                    borderRadius: 12,
                    prefixIcon: const Icon(size: 22, Icons.search),
                    backgroundColor: AppColors.white,
                    hintText: LocaleKeys.patientDashboardScreen_searchBy.tr,
                    fontSize: 13,
                    onChanged: (value) async {
                      widget.controller.search.value = value;
                    },
                  ),
                  gapH28,
                  if (widget.controller.userRole.value == UserRole.patient) ...[
                    AppText.primary(
                      LocaleKeys.patientDashboardScreen_appointmentHistory.tr,
                      fontWeight: FontWeightType.bold,
                    ),
                  ],
                  if (widget.controller.userRole.value ==
                      UserRole.reception) ...[
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText.primary(
                            "${widget.controller.currentShiftEntity.value.shift?.capitalizeFirstLetter()} Appointments",
                            fontWeight: FontWeightType.bold,
                            fontSize: 16,
                            color: AppColors.black,
                          ),
                          InkWell(
                            onTap: () {
                              widget.controller
                                  .hideReceptionAppointmentDetailsLayout
                                  .toggle();
                            },
                            child: AppText.primary(
                              widget
                                      .controller
                                      .hideReceptionAppointmentDetailsLayout
                                      .value
                                  ? LocaleKeys
                                      .receptionDashboardScreen_viewAll.tr
                                  : LocaleKeys
                                      .receptionDashboardScreen_viewLess.tr,
                              color: AppColors.grey60,
                            ),
                          ),
                        ],
                      ),
                    ),
                    gapH10,
                    Obx(
                      () => AppText.primary(
                        "${widget.controller.currentShiftEntity.value.date?.toFormattedDate()} / ${widget.controller.currentShiftEntity.value.day}",
                        fontSize: 14,
                        color: AppColors.darkGrey,
                      ),
                    ),
                  ],
                  gapH18,
                  Obx(() {
                    final appointments = widget.controller.appointmentsHistory;
                    return Column(
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: appointments.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                widget.controller.navigateToTokenDetails(
                                  appointments[index].tokenId ?? 0,
                                );
                              },
                              child: Column(
                                children: [
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                                    "${(appointments[index].date)?.toFormattedDate()} • ${widget.controller.tokenNumberLabel.value} (#${appointments[index].tokenNumber})"
                                                    "${(widget.controller.userRole.value == UserRole.doctor || widget.controller.userRole.value == UserRole.reception) ? " - ${appointments[index].numberOfPatients} Patient" : ""}",
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeightType.regular,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                // RIGHT SIDE — IntrinsicWidth to size only as needed
                                                if (widget.controller.userRole
                                                        .value ==
                                                    UserRole.reception)
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left:
                                                            8.0), // slight space between
                                                    child: IntrinsicWidth(
                                                      child: RoundBorderButton(
                                                        height: 18,
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 14.0),
                                                        color: appointments[index]
                                                                    .status ==
                                                                "pending"
                                                            ? AppColors.pendingColor
                                                            : AppColors
                                                                .checkedColor,
                                                        textColor: AppColors.white,
                                                        title: appointments[
                                                                        index]
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
                                  if (widget.controller.userRole.value ==
                                      UserRole.patient) ...[
                                    appointments[index].prescription?.isNotEmpty ==
                                            true
                                        ? Row(
                                            children: [
                                              const SizedBox(width: 56),
                                              IntrinsicWidth(
                                                child: RoundBorderButton(
                                                  height: 24,
                                                  color:
                                                      AppColors.prescriptionColor,
                                                  textColor: AppColors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeightType.medium,
                                                  radius: 50,
                                                  title: LocaleKeys
                                                      .patientDashboardScreen_prescription
                                                      .tr,
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 14),
                                                  onPressed: () {
                                                    // Handle button press
                                                  },
                                                ),
                                              ),
                                            ],
                                          )
                                        : const SizedBox.shrink(),
                                  ],
                                  // returns empty widget if false
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return gapH16;
                          },
                        ),
                        // Loading indicator for pagination
                        if (widget.controller.isLoadingMore.value)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        // End of list indicator
                        if (!widget.controller.hasMoreData.value &&
                            widget.controller.appointmentsHistory.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Center(
                              child: AppText.primary(
                                "No more appointments",
                                color: AppColors.grey60,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReceptionAppointmentsCard({
    required String title,
    required String subtitle,
    required String dateInfo,
    Color? backgroundColor,
    double titleFontSize = 60,
    Color textColor = AppColors.black,
    TextAlign textAlign = TextAlign.start,
    bool isActive = false,
  }) {
    return Container(
      height: 180,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
            color: isActive
                ? AppColors.appointmentBoxWidthColor
                : AppColors.grey80,
            width: 1),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: textAlign == TextAlign.center
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          AppText.h6(
            title,
            fontSize: titleFontSize,
            fontWeight: FontWeightType.semiBold,
            color: textColor,
          ),
          AppText.primary(
            subtitle,
            fontSize: 16,
            fontWeight: FontWeightType.semiBold,
            color: textColor,
          ),
          gapH6,
          AppText.primary(
            dateInfo,
            fontSize: 12,
            color: AppColors.darkGrey,
            textAlign: textAlign,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(NavController navController) {
    return SafeArea(
      child: Container(
        color: AppColors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: RoundBorderButton(
              height: 50,
              title: LocaleKeys.receptionDashboardScreen_addPatient.tr,
              color: AppColors.primary,
              fontSize: 14,
              onPressed: () {
                if (widget.controller.currentShiftEntity.value.bookingEnable!) {
                  navController.changeTab(1);
                } else {
                  Util.showErrorToast(
                    message:
                        widget.controller.currentShiftEntity.value.message!,
                    context: context,
                  );
                }
              }),
        ),
      ),
    );
  }

  void showFilterBottomSheet(BuildContext context, OnFilterSubmit onSubmit) {
    final navController = Get.find<NavController>();

    navController.shouldShowNavBar.value = false;
    FilterBottomSheetBinding().dependencies();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => FilterBottomSheet(onSubmit: onSubmit),
    ).whenComplete(() {
      navController.shouldShowNavBar.value = true;
    });
  }
}
