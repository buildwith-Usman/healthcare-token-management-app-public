import 'package:doctor_patient_token_mobile_app/app/config/app_colors.dart';
import 'package:doctor_patient_token_mobile_app/app/config/app_image.dart';
import 'package:doctor_patient_token_mobile_app/app/services/app_get_view_stateful.dart';
import 'package:doctor_patient_token_mobile_app/app/utils/app_extensions.dart';
import 'package:doctor_patient_token_mobile_app/app/utils/sizes.dart';
import 'package:doctor_patient_token_mobile_app/app/utils/string_extension.dart';
import 'package:doctor_patient_token_mobile_app/presentation/doctor_dashboard/doctor_dashboard_controller.dart';
import 'package:doctor_patient_token_mobile_app/presentation/doctor_dashboard/filter_bottom_sheet.dart';
import 'package:doctor_patient_token_mobile_app/presentation/doctor_dashboard/filter_bottom_sheet_binding.dart';
import 'package:doctor_patient_token_mobile_app/presentation/widgets/app_text.dart';
import 'package:doctor_patient_token_mobile_app/presentation/widgets/button/round_border_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/config/app_enum.dart';
import '../../app/config/app_icon.dart';
import '../../app/utils/util.dart';
import '../../generated/locales.g.dart';
import '../navigation/nav_controller.dart';
import '../widgets/textfield/search_textfield.dart';

typedef OnFilterSubmit = void Function(
    DateTime selectedDate, String selectedShift);

class DoctorDashboardPage extends GetStatefulWidget<DoctorDashboardController> {
  const DoctorDashboardPage({super.key});

  @override
  State<DoctorDashboardPage> createState() => _DoctorDashboardPageState();
}

class _DoctorDashboardPageState extends State<DoctorDashboardPage> {
  final List<String> tabs = ["All", "Manually", "Online"];
  final NavController navController = Get.find();
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
    return WillPopScope(
        onWillPop: () async {
          // widget.controller.goToDashboard();
          return false; // Prevent default back navigation
        },
        child: Scaffold(
            backgroundColor: AppColors.offWhite,
            resizeToAvoidBottomInset: true,
            body: _buildDashboardContent(),
            bottomNavigationBar: _buildBottomNav(navController)));
  }

  Widget _buildDashboardContent() {
    return SafeArea(
        child: SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => Container(
              decoration: BoxDecoration(
                gradient: widget.controller.viewAllPatients.value
                    ? getGradient(widget.controller.shift.value)
                    : null,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.controller.viewAllPatients.value) ...[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(70),
                              color: AppColors.grey95,
                            ),
                            child: Center(
                              child: AppImage.drImage.widget(),
                            ),
                          ),
                          gapW8,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText.primary(
                                  '${widget.controller.currentShiftEntity.value.shift?.capitalizeFirst}, ${widget.controller.currentUserName.value}',
                                  color: AppColors.darkGrey,
                                  fontSize: 14,
                                  fontWeight: FontWeightType.regular,
                                ),
                                gapH4,
                                AppText.primary(
                                  'MBBS Child Specialist',
                                  fontWeight: FontWeightType.semiBold,
                                  fontSize: 16,
                                ),
                              ],
                            ),
                          ),
                          // const Icon(Icons.notifications, size: 28),
                        ],
                      ),
                      gapH20,
                      Container(
                        padding: const EdgeInsets.fromLTRB(22, 26, 22, 26),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.lightGrey,
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.05),
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            /// Count + Morning button
                            Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppText.primary(
                                          widget.controller.totalAppointments
                                              .value,
                                          fontSize: 65,
                                          fontWeight: FontWeightType.bold,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Icon(
                                            Icons.wb_sunny_outlined,
                                            size: 24,
                                          ),
                                        ),
                                      ],
                                    ),
                                    AppText.primary(
                                      LocaleKeys
                                          .doctorDashboardScreen_appointment.tr,
                                      fontWeight: FontWeightType.semiBold,
                                      fontSize: 16,
                                    ),
                                    gapH8,
                                    AppText.primary(
                                      "${widget.controller.currentShiftEntity.value.date?.toFormattedDate()} - ${widget.controller.currentShiftEntity.value.day}",
                                      color: AppColors.grey60,
                                    ),
                                  ],
                                )),
                                Expanded(
                                  child: timeToggleButton(
                                    selectedShift:
                                        widget.controller.shift.value,
                                    onChanged: (newShift) {
                                      setState(() {
                                        widget.controller.shift.value =
                                            newShift;
                                        widget.controller.currentShiftEntity
                                            .value.shift = newShift.name;
                                        widget.controller
                                            .getAppointmentHistory();
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                    if (!widget.controller.viewAllPatients.value) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// Back Arrow
                          InkWell(
                            child: const Icon(
                              Icons.arrow_back_ios,
                              size: 20,
                            ),
                            onTap: () {
                              widget.controller.viewAllPatients.value = true;
                              widget.controller.currentShiftEntity.value.shift =
                                  widget.controller.shift.value.name;
                              widget.controller.currentShiftEntity.value.date =
                                  widget.controller.currentShiftDate.value;
                              widget.controller.bookType.value = '';
                              widget.controller.getAppointmentHistory();
                            },
                          ),
                          Row(
                            children: [
                              gapW20,
                              InkWell(
                                child: AppIcon.filter.widget(),
                                onTap: () {
                                  showFilterBottomSheet(context,
                                      (selectedDate, selectedShift) {
                                    widget.controller.currentShiftEntity.value
                                        .shift = selectedShift;
                                    widget.controller.currentShiftEntity.value
                                            .date =
                                        selectedDate.dateToStringWithFormat(
                                            format: "yyyy-MM-dd");
                                    widget.controller.getAppointmentHistory();
                                  });
                                },
                              ),
                              // gapW20,
                              // InkWell(
                              //   child: AppIcon.notification.widget(),
                              //   onTap: () {
                              //     // Logic For Notification Tap
                              //   },
                              // ),
                            ],
                          ),
                        ],
                      ),
                      gapH10,
                      AppText.primary(
                        "${widget.controller.currentShiftEntity.value.shift?.capitalizeFirstLetter()}",
                        fontSize: 26,
                        fontWeight: FontWeightType.bold,
                      ),
                      gapH6,
                      AppText.primary(
                        "Total Appointments: (${widget.controller.totalAppointments.value})",
                        fontSize: 14,
                        fontWeight: FontWeightType.medium,
                        color: AppColors.black,
                      ),
                      gapH20,
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.white,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: List.generate(tabs.length, (index) {
                            final selected =
                                widget.controller.selectedTabIndex.value ==
                                    index;
                            return Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  widget.controller.changeTab(index);
                                },
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
                    gapH16,
                    SearchTextField(
                      height: 60,
                      borderRadius: 10,
                      prefixIcon: const Icon(size: 26, Icons.search),
                      backgroundColor: AppColors.white,
                      hintText: LocaleKeys.doctorDashboardScreen_searchBy.tr,
                      fontSize: 12,
                      onChanged: (value) {
                        widget.controller.search.value = value;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText.primary(
                        "New Appointments",
                        fontWeight: FontWeightType.bold,
                        fontSize: 16,
                        color: AppColors.black,
                      ),
                      if (widget.controller.viewAllPatients.value) ...[
                        InkWell(
                          onTap: () {
                            widget.controller.viewAllPatients.value = false;
                          },
                          child: AppText.primary(
                            LocaleKeys.receptionDashboardScreen_viewAll.tr,
                            color: AppColors.grey60,
                          ),
                        ),
                      ]
                    ],
                  ),
                  gapH10,
                  AppText.primary(
                    "${widget.controller.currentShiftEntity.value.shift?.capitalizeFirstLetter()} / ${widget.controller.currentShiftEntity.value.date?.toFormattedDate()} - ${widget.controller.currentShiftEntity.value.day}",
                    fontSize: 14,
                    color: AppColors.darkGrey,
                  ),
                  gapH16,
                ],
              ),
            ),
          ),
          gapH10,
          Obx(() {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: widget.controller.appointmentsHistory.length,
                    itemBuilder: (context, index) {
                      final appointments = widget.controller.appointmentsHistory;
                      return GestureDetector(
                        onTap: () {
                          if (appointments[index].type == 'online') {
                            widget.controller.navigateToPatientDetails();
                          } else {
                            widget.controller.navigateToTokenDetails(
                              appointments[index].tokenId ?? 0,
                            );
                          }
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
                                      (appointments[index].name ?? "Ikram Medical")
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
                                        appointments[index].name ?? "Ikram Medical",
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
                                              "${(appointments[index].date)?.toFormattedDate()} • TN (#${appointments[index].tokenNumber}) - ${appointments[index].numberOfPatients} Patient",
                                              fontSize: 12,
                                              fontWeight: FontWeightType.regular,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0), // slight space between
                                            child: IntrinsicWidth(
                                              child: RoundBorderButton(
                                                height: 18,
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 14.0),
                                                color: appointments[index].status ==
                                                        "pending"
                                                    ? AppColors.pendingColor
                                                    : AppColors.checkedColor,
                                                textColor: AppColors.white,
                                                title: appointments[index].status ==
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
                  if (!widget.controller.isLoadingMore.value &&
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
              ),
            );
          }),
        ],
      ),
    ));
  }

  Widget _buildBottomNav(NavController navController) {
    return SafeArea(
      child: Container(
        color: AppColors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: RoundBorderButton(
              height: 50,
              title: LocaleKeys.doctorDashboardScreen_patientChecking.tr,
              color: AppColors.primary,
              onPressed: () {
                navController.changeTab(1,startCheckingProcess: true);
              }),
        ),
      ),
    );
  }

  Gradient? getGradient(Shift shift) {
    switch (shift) {
      case Shift.morning:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.morningTopGradient,
            AppColors.morningBottomGradient
          ],
        );
      case Shift.evening:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.eveningTopGradient,
            AppColors.eveningBottomGradient
          ],
        );
      default:
        return null;
    }
  }

  Widget timeToggleButton({
    required Shift selectedShift,
    required ValueChanged<Shift> onChanged,
  }) {
    Widget buildToggle({
      required bool selected,
      required VoidCallback onTap,
      required Widget icon,
      required String label,
      required Color selectedColor,
      Color? unselectedBorderColor,
    }) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: selected ? selectedColor : AppColors.white,
            borderRadius: BorderRadius.circular(50),
            border: selected
                ? null
                : Border.all(color: unselectedBorderColor ?? AppColors.primary),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(width: 8),
              AppText.primary(
                label,
                color: selected ? AppColors.white : AppColors.darkGrey,
                fontWeight: FontWeightType.medium,
                fontSize: 12,
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        buildToggle(
          selected: selectedShift == Shift.morning,
          onTap: () => onChanged(Shift.morning),
          icon: AppImage.sun.widget(
            color: selectedShift == Shift.morning
                ? AppColors.white
                : AppColors.primary,
          ),
          label: LocaleKeys.doctorDashboardScreen_morning.tr,
          selectedColor: AppColors.primary,
        ),
        gapH12,
        buildToggle(
          selected: selectedShift == Shift.evening,
          onTap: () => onChanged(Shift.evening),
          icon: AppIcon.moon.widget(
            color: selectedShift == Shift.evening
                ? AppColors.white
                : AppColors.darkGrey,
          ),
          label: LocaleKeys.doctorDashboardScreen_evening.tr,
          selectedColor: AppColors.black,
          unselectedBorderColor: AppColors.darkGrey,
        ),
      ],
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
