import 'package:doctor_patient_token_mobile_app/app/config/app_colors.dart';
import 'package:doctor_patient_token_mobile_app/app/services/app_get_view_stateful.dart';
import 'package:doctor_patient_token_mobile_app/app/utils/app_extensions.dart';
import 'package:doctor_patient_token_mobile_app/app/utils/sizes.dart';
import 'package:doctor_patient_token_mobile_app/presentation/checking_process/checking_process_controller.dart';
import 'package:doctor_patient_token_mobile_app/presentation/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/config/app_enum.dart';
import '../../app/config/app_icon.dart';
import '../navigation/nav_controller.dart';

class CheckingProcessPage extends GetStatefulWidget<CheckingProcessController> {
  const CheckingProcessPage({super.key});

  @override
  State<CheckingProcessPage> createState() => _CheckingProcessPageState();
}

class _CheckingProcessPageState extends State<CheckingProcessPage> {
  final NavController navController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: _buildCheckingProcessContent(context),
    );
  }

  Widget _buildCheckingProcessContent(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Row(
                children: [
                  InkWell(
                    child: AppIcon.leftArrowIcon.widget(height: 24, width: 24),
                    onTap: () {
                      navController.changeTab(0);
                    },
                  ),
                  Expanded(
                    child: Center(
                      child: AppText.primary(
                        'Checking Process',
                        fontWeight: FontWeightType.semiBold,
                      ),
                    ),
                  ),
                  gapW24,
                ],
              ),
            ),
            gapH12,
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Obx(() {
                      final splitTime =
                          widget.controller.currentTime.value.split(" ");
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AppText.primary(
                            splitTime[0],
                            fontSize: 35,
                            fontWeight: FontWeightType.bold,
                            color: AppColors.black,
                          ),
                          gapW4,
                          Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: AppText.primary(
                              splitTime.length > 1 ? splitTime[1] : '',
                              fontSize: 16,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      );
                    }),
                    gapH20,
                    const ResponsiveLegendRow(),
                    gapH8,
                    const Divider(
                      color: AppColors.grey90,
                      thickness: 1,
                    ),
                    gapH8,
                    Obx(() {
                      final tokens = widget.controller.allTokenStatusList;
                      final selected =
                          widget.controller.selectedTokenNumber.value;
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
                          final isBooked = token?.status ==
                              TokenStatusEnum.booked.toString();
                          final isSelected = token?.number ==
                              widget.controller.selectedTokenNumber.value;
                          final status = token?.status.toTokenStatus();
                          if (token != null && status != null) {
                            return _buildBox(context, token.number, status,
                                token.numberOfPatients, selected, () async {
                              showPatientActionDialog(
                                context: context,
                                onCheckedPatient: () async {
                                  // Your logic for checked patient
                                  // widget.controller.selectedTokenNumber.value =
                                  //     token.number;
                                  await widget.controller.checkedToken(
                                      token.tokenId.toString(),
                                      TokenStatusEnum.checked.name,
                                      onResult: (success) async {
                                    print("Checked Result $success");
                                    if (success) {
                                      print("Checked Called");
                                      widget.controller.fetchAllTokenStatuses();
                                    } else {
                                      // Handle failure
                                    }
                                  });
                                },
                                onSkipPatient: () async {
                                  // Your logic for skipped patient
                                  // widget.controller.selectedTokenNumber.value =
                                  //     token.number;
                                  await widget.controller.checkedToken(
                                      token.tokenId.toString(),
                                      TokenStatusEnum.skipped.name,
                                      onResult: (success) async {
                                    print("Skipped Result $success");
                                    if (success) {
                                      print("Skipped Called");
                                      widget.controller.fetchAllTokenStatuses();
                                    } else {
                                      // Handle failure
                                    }
                                  });
                                },
                              );
                            });
                          } else {
                            return const SizedBox(); // or handle gracefully
                          }
                        },
                      );
                    }),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

Future<void> showPatientActionDialog({
  required BuildContext context,
  required VoidCallback onCheckedPatient,
  required VoidCallback onSkipPatient,
}) async {
  await showDialog(
    context: context,
    barrierDismissible: false, // Prevent closing by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          "Patient Action",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text(
          "Please choose an action for this patient:",
          style: TextStyle(fontSize: 16),
        ),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.done, color: Colors.green),
            label: const Text("Checked Patient"),
            onPressed: () {
              Navigator.of(context).pop();
              onCheckedPatient();
            },
          ),
          TextButton.icon(
            icon: const Icon(Icons.skip_next, color: Colors.orange),
            label: const Text("Skip Patient"),
            onPressed: () {
              Navigator.of(context).pop();
              onSkipPatient();
            },
          ),
          TextButton(
            child: const Text("Cancel", style: TextStyle(color: Colors.red)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
    },
  );
}

Widget _buildBox(
  BuildContext context,
  int token,
  TokenStatusEnum status,
  int numberOfPatients,
  int? selectedTokenNumber,
  VoidCallback? onTap,
) {
  final screenWidth = MediaQuery.of(context).size.width;
  final boxSize = screenWidth * 0.15;

  Color getBoxColor() {
    print(
        'token status with number $token ----- status ----- $status ---- selected token number ---- $selectedTokenNumber');
    if (status == TokenStatusEnum.checked) {
      return AppColors.checkedTokenBoxColor;
    }

    if (status == TokenStatusEnum.skipped) {
      return AppColors.red.withOpacity(0.7);
    }

    if (selectedTokenNumber != null && selectedTokenNumber == token) {
      return AppColors.checkedColor; // or any selected color
    }

    if (status == TokenStatusEnum.pending ||
        status == TokenStatusEnum.paymentRequired) {
      switch (numberOfPatients) {
        case 1:
          return AppColors.white;
        case 2:
          return AppColors.twoPatientsBoxColor;
        case 3:
          return AppColors.threePatientsBoxColor;
        default:
          return AppColors.white;
      }
    }
    return AppColors.bookedTokenBgColor;
  }

  Color getTextColor() {
    if (status == TokenStatusEnum.checked) {
      return AppColors.checkedColor;
    } else if (status == TokenStatusEnum.skipped) {
      return AppColors.white;
    }

    if (selectedTokenNumber != null && selectedTokenNumber == token) {
      return AppColors.white; // or any selected color
    }

    if (status == TokenStatusEnum.pending ||
        status == TokenStatusEnum.paymentRequired) {
      switch (numberOfPatients) {
        case 1:
          return AppColors.unBookedTokenBoxTextColor;
        case 2:
          return AppColors.primary;
        case 3:
          return AppColors.threePatientsColor;
        default:
          return AppColors.white;
      }
    }
    return AppColors.bookedTokenBoxTextColor;
  }

  bool isClickable() {
    return status == TokenStatusEnum.pending ||
        status == TokenStatusEnum.skipped ||
        status == TokenStatusEnum.paymentRequired;
  }

  return GestureDetector(
    onTap: isClickable() ? onTap : null,
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

class ResponsiveLegendRow extends StatelessWidget {
  final List<Widget> items = const [
    _LegendDot(color: AppColors.checkedColor, label: "Checked"),
    _LegendDot(color: AppColors.white, label: "1 Patient"),
    _LegendDot(color: AppColors.patientColor2, label: "2 Patients"),
    _LegendDot(color: AppColors.brown, label: "3 Patients"),
  ];

  const ResponsiveLegendRow({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth;
        double itemWidth = 50; // Estimated width per item
        double spacing = 12;

        int itemsPerRow =
            ((maxWidth + spacing) / (itemWidth + spacing)).floor();

        if (itemsPerRow >= items.length) {
          // All items fit in one line
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _buildSpacedItems(items),
          );
        } else {
          // Split items into two lines
          List<Widget> firstRow =
              _buildSpacedItems(items.sublist(0, itemsPerRow));
          List<Widget> secondRow =
              _buildSpacedItems(items.sublist(itemsPerRow));

          return Column(
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: firstRow),
              const SizedBox(height: 8),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: secondRow),
            ],
          );
        }
      },
    );
  }

  List<Widget> _buildSpacedItems(List<Widget> widgets) {
    return List.generate(
      widgets.length * 2 - 1,
      (index) => index.isEven ? widgets[index ~/ 2] : const SizedBox(width: 10),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 4,
          backgroundColor: color,
        ),
        gapW4,
        AppText.primary(label,
            fontWeight: FontWeightType.medium,
            fontSize: 12,
            color: AppColors.black)
      ],
    );
  }
}
