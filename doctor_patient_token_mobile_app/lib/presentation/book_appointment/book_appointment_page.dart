import 'package:doctor_patient_token_mobile_app/app/config/app_enum.dart';
import 'package:doctor_patient_token_mobile_app/app/utils/sizes.dart';
import 'package:doctor_patient_token_mobile_app/app/utils/string_extension.dart';
import 'package:doctor_patient_token_mobile_app/app/utils/util.dart';
import 'package:doctor_patient_token_mobile_app/generated/locales.g.dart';
import 'package:doctor_patient_token_mobile_app/presentation/payment/payment_binding.dart';
import 'package:doctor_patient_token_mobile_app/presentation/payment/payment_bottom_sheet.dart';
import 'package:doctor_patient_token_mobile_app/presentation/widgets/app_text.dart';
import 'package:doctor_patient_token_mobile_app/presentation/widgets/button/round_border_button.dart';
import 'package:doctor_patient_token_mobile_app/presentation/widgets/textfield/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/config/app_colors.dart';
import 'package:get/get.dart';

import '../../app/config/app_icon.dart';
import '../../app/services/app_get_view_stateful.dart';
import '../appCommonWidgets/patient_form.dart';
import '../navigation/nav_controller.dart';
import 'book_appointment_controller.dart';

class BookAppointmentPage extends GetStatefulWidget<BookAppointmentController> {
  const BookAppointmentPage({super.key});

  @override
  State<BookAppointmentPage> createState() => _BookAppointmentPageState();
}

class _BookAppointmentPageState extends State<BookAppointmentPage> {
  final NavController navController = Get.find();

  int? selectedNumberOfPatientOption;
  final GlobalKey _numberOfPatientsTextFieldKey = GlobalKey();

  void _onDropdownNoOfPatientItemSelected(int selected) {
    setState(() {
      selectedNumberOfPatientOption = selected;
      widget.controller.updatePatientCount(selectedNumberOfPatientOption ?? 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: _buildBookAppointmentPageContent(context),
    );
  }

  Widget _buildBookAppointmentPageContent(BuildContext context) {
    return SafeArea(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  child: AppIcon.leftArrowIcon.widget(height: 24, width: 24),
                  onTap: () {
                    navController.changeTab(0);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10, left: 5),
                  child: AppText.h3(
                    LocaleKeys.bookAppointmentScreen_bookAppointment.tr,
                    fontSize: 26,
                    fontWeight: FontWeightType.bold,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Obx(() {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.lightGrey,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: RoundBorderButton(
                              height: 32,
                              radius: 8,
                              title:
                                  LocaleKeys.bookAppointmentScreen_morning.tr,
                              color: widget.controller.selectedTab.value
                                  ? AppColors.primary
                                  : AppColors.lightGrey,
                              textColor: widget.controller.selectedTab.value
                                  ? AppColors.white
                                  : AppColors.black,
                              onPressed: () {
                                // Nothing to do
                              },
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: RoundBorderButton(
                              height: 32,
                              radius: 8,
                              title:
                                  LocaleKeys.bookAppointmentScreen_evening.tr,
                              color: widget.controller.selectedTab.value
                                  ? AppColors.lightGrey
                                  : AppColors.primary,
                              textColor: widget.controller.selectedTab.value
                                  ? AppColors.black
                                  : AppColors.white,
                              onPressed: () {
                                // Nothing to do
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
                gapH16,
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(children: [
                      AppText.primary(
                          '${widget.controller.currentShiftEntity.value.date?.toFormattedDate()} / ${widget.controller.currentShiftEntity.value.shift?.capitalizeFirstLetter()}',
                          fontSize: 16,
                          fontWeight: FontWeightType.bold)
                    ]),
                  ),
                ),
                gapH14,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    width: double.infinity,
                    height: 1,
                    color: AppColors.lightDivider,
                  ),
                ),
                gapH14,
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: AppText.primary(
                      'Select Slot',
                      fontWeight: FontWeightType.semiBold,
                      fontSize: 14,
                      color: AppColors.black,
                    )),
                gapH14,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: Column(
                    children: [
                      Obx(() {
                        final tokens = widget.controller.allTokenStatusList;
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 2,
                            childAspectRatio: 1,
                          ),
                          itemCount: tokens.length,
                          itemBuilder: (context, index) {
                            final token = tokens[index];

                            return Obx(() {
                              var isBooked = token?.status ==
                                      TokenStatusEnum.booked.name ||
                                  token?.status ==
                                      TokenStatusEnum.pending.name ||
                                  token?.status ==
                                      TokenStatusEnum.paymentRequired.name;
                              if (token?.status == 'payment required') {
                                isBooked = true;
                              }
                              final isSelected = token?.number ==
                                  widget.controller.selectedTokenNumber.value;
                              return _buildBox(
                                context,
                                token!.number,
                                isBooked,
                                isSelected,
                                () {
                                  if (!isBooked) {
                                    widget.controller.selectedTokenNumber
                                        .value = token.number;
                                  }
                                },
                              );
                            });
                          },
                        );
                      }),
                    ],
                  ),
                ),
                gapH26,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Obx(
                    () => FormTextField(
                      key: _numberOfPatientsTextFieldKey,
                      titleText:
                          LocaleKeys.bookAppointmentScreen_numberOfPatients.tr,
                      height: 50,
                      fontSize: 12,
                      readOnly: true,
                      initialValue: widget
                          .controller.selectedNumberOfPatients.value
                          .toString(),
                      controller: widget.controller.numberOfPatients,
                      suffixIcon: AppIcon.dropDown.widget(),
                      onSuffixIconTap: () {
                        _showNumberOfPatientsDropdown(
                            context, _numberOfPatientsTextFieldKey);
                        // Handle the tap event here
                      },
                    ),
                  ),
                ),
                gapH16,
                Obx(() {
                  final patientCount =
                      widget.controller.selectedNumberOfPatients.value;
                  if (patientCount == 0) {
                    return const SizedBox();
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: patientCount,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return PatientForm(index: index);
                    },
                  );
                }),
                gapH8,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Obx(
                    () => RoundBorderButton(
                        height: 50,
                        title: widget.controller.userRole.value ==
                                UserRole.reception
                            ? LocaleKeys.bookAppointmentScreen_submit.tr
                            : LocaleKeys.bookAppointmentScreen_next.tr,
                        color: AppColors.primary,
                        onPressed: () async {
                          if (widget.controller.validatePatients(context)) {
                            if (widget.controller.paymentLink.isNotEmpty) {
                              try {
                                final Uri uri =
                                    Uri.parse(widget.controller.paymentLink);
                                final launched = await launchUrl(
                                  uri,
                                  mode: LaunchMode.externalApplication,
                                );

                                if (!launched) {
                                  Util.showErrorToast(
                                    message: "Unable to open payment page.",
                                    context: context,
                                  );
                                }
                              } catch (e) {
                                print('Error launching URL: $e');
                                Util.showErrorToast(
                                  message: "Failed to open payment page: $e",
                                  context: context,
                                );
                              }
                            } else {
                              widget.controller.submitPatientsData(
                                  onSuccess: (String paymentLink) async {
                                if (widget.controller.userRole.value ==
                                    UserRole.reception) {
                                  Util.showSuccessToast(
                                      message: "Appointment Confirmed",
                                      context: context);
                                      widget.controller.resetControllers();
                                  widget.controller.fetchAllTokenStatuses();
                                } else {
                                  try {
                                    final Uri uri = Uri.parse(paymentLink);

                                    final launched = await launchUrl(
                                      uri,
                                      mode: LaunchMode.externalApplication,
                                    );

                                    if (!launched) {
                                      Util.showErrorToast(
                                        message: "Unable to open payment page.",
                                        context: context,
                                      );
                                    }
                                  } catch (e) {
                                    print('Error launching URL: $e');
                                    Util.showErrorToast(
                                      message:
                                          "Failed to open payment page: $e",
                                      context: context,
                                    );
                                  }
                                }
                              });
                            }
                          }
                        }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBox(
    BuildContext context,
    int token,
    bool isBooked,
    bool isSelected,
    VoidCallback? onTap, // allow tap handling from parent
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final boxSize = screenWidth * 0.15;

    Color getBoxColor() {
      if (isBooked) return AppColors.bookedTokenBgColor;
      if (isSelected) return AppColors.primary;
      return AppColors.white;
    }

    Color getTextColor() {
      if (isBooked) return AppColors.bookedTokenBoxTextColor;
      if (isSelected) return AppColors.white;
      return AppColors.unBookedTokenBoxTextColor;
    }

    return GestureDetector(
      onTap: isBooked ? null : onTap, // Disable tap if booked
      child: Container(
        margin: const EdgeInsets.all(5),
        width: boxSize,
        height: boxSize,
        decoration: BoxDecoration(
          color: getBoxColor(),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.grey90,
            width: 1.0,
          ),
        ),
        child: Center(
          child: Text(
            '$token',
            style: TextStyle(
              color: getTextColor(),
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  void _showNumberOfPatientsDropdown(
      BuildContext context, GlobalKey textFieldKey) async {
    // Ensure the GlobalKey context is valid and the TextFormField is rendered
    final RenderBox? button =
        textFieldKey.currentContext?.findRenderObject() as RenderBox?;
    if (button == null) {
      return; // If button is null, we can't proceed with positioning.
    }

    final RenderBox? overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox?;
    if (overlay == null) {
      return; // If overlay is null, we can't show the dropdown.
    }

    // Get the position of the TextFormField relative to the screen
    final Offset buttonOffset =
        button.localToGlobal(Offset.zero, ancestor: overlay);

    // Get the width and height of the TextFormField
    final double buttonHeight = button.size.height;
    final double buttonWidth = button.size.width;

    // Debugging the position and size
    print("Button Offset: $buttonOffset");
    print("Button Width: $buttonWidth, Button Height: $buttonHeight");

    // Create a position for the dropdown that is below and aligned to the full width of the TextFormField
    final RelativeRect position = RelativeRect.fromLTRB(
      buttonOffset.dx, // Left aligned with the TextFormField
      buttonOffset.dy + buttonHeight, // Dropdown starts below the TextFormField
      buttonOffset.dx + buttonWidth, // Right aligned with the TextFormField
      buttonOffset.dy +
          buttonHeight +
          50, // Adjust the dropdown height as needed
    );

    // Show the dropdown menu with the updated position and full width
    int? selectedValue = await showMenu<int>(
      context: context,
      position: position,
      items: [
        PopupMenuItem<int>(
          value: 1,
          child: SizedBox(
            width: buttonWidth, // Full width of the TextFormField
            child: const Text('1'),
          ),
        ),
        PopupMenuItem<int>(
          value: 2,
          child: SizedBox(
            width: buttonWidth, // Full width of the TextFormField
            child: const Text('2'),
          ),
        ),
        PopupMenuItem<int>(
          value: 3,
          child: SizedBox(
            width: buttonWidth, // Full width of the TextFormField
            child: const Text('3'),
          ),
        ),
      ],
    );

    if (selectedValue != null) {
      _onDropdownNoOfPatientItemSelected(selectedValue); // Handle the selection
    }
  }

  void showPaymentBottomSheet(BuildContext context, int tokenId) {
    final navController = Get.find<NavController>();

    navController.shouldShowNavBar.value = false;
    PaymentBinding().dependencies();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => PaymentBottomSheet(tokenId: tokenId),
    ).whenComplete(() {
      navController.shouldShowNavBar.value = true;
    });
  }
}
