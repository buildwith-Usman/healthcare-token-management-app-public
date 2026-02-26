import 'dart:io';

import 'package:doctor_patient_token_mobile_app/app/config/app_colors.dart';
import 'package:doctor_patient_token_mobile_app/app/config/app_enum.dart';
import 'package:doctor_patient_token_mobile_app/app/services/app_get_view_stateful.dart';
import 'package:doctor_patient_token_mobile_app/app/utils/sizes.dart';
import 'package:doctor_patient_token_mobile_app/app/utils/string_extension.dart';
import 'package:doctor_patient_token_mobile_app/app/utils/util.dart';
import 'package:doctor_patient_token_mobile_app/generated/locales.g.dart';
import 'package:doctor_patient_token_mobile_app/presentation/appointments/detail_appointment_controller.dart';
import 'package:doctor_patient_token_mobile_app/presentation/widgets/app_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../app/config/app_icon.dart';
import '../../app/services/app_storage.dart';
import '../widgets/button/round_border_button.dart';

class DetailAppointmentPage
    extends GetStatefulWidget<DetailAppointmentController> {
  const DetailAppointmentPage({super.key});

  @override
  State<DetailAppointmentPage> createState() => _DetailAppointmentPage();
}

class _DetailAppointmentPage extends State<DetailAppointmentPage> {
  int? selectedIndex;
  Rx<File?> pickedImage = Rx<File?>(null);
  RxString uploadedImageUrl = RxString('');
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appointmentDetailsBg,
      body: _buildAppointmentContent(),
    );
  }

  Widget _buildAppointmentContent() {
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      bottom: false,
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            gapH24,
            SizedBox(
              height: screenHeight / 5,
              child: Stack(
                children: [
                  // Base Stack (your existing patient circles layout)
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        if (widget.controller.tokenDetailsEntity.value
                                    .patientsList?.length ==
                                1 ||
                            widget.controller.tokenDetailsEntity.value
                                    .patientsList?.length ==
                                3)
                          _buildBigCircle(Util.getInitials(widget
                                  .controller
                                  .tokenDetailsEntity
                                  .value
                                  .patientsList?[0]
                                  .patientName ??
                              'AA')),
                        if (widget.controller.tokenDetailsEntity.value
                                .patientsList?.length ==
                            2) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildSmallCircle(
                                  Util.getInitials(widget
                                          .controller
                                          .tokenDetailsEntity
                                          .value
                                          .patientsList?[0]
                                          .patientName ??
                                      'AA'),
                                  size: 70),
                              const SizedBox(width: 0),
                              _buildSmallCircle(
                                  Util.getInitials(widget
                                          .controller
                                          .tokenDetailsEntity
                                          .value
                                          .patientsList?[1]
                                          .patientName ??
                                      'AA'),
                                  size: 70,
                                  color: AppColors.primary),
                            ],
                          )
                        ],
                        if (widget.controller.tokenDetailsEntity.value
                                .patientsList?.length ==
                            3) ...[
                          Positioned(
                            bottom: -10,
                            left: 5,
                            child: _buildSmallCircle(Util.getInitials(widget
                                    .controller
                                    .tokenDetailsEntity
                                    .value
                                    .patientsList?[1]
                                    .patientName ??
                                'AA')),
                          ),
                          Positioned(
                            bottom: -10,
                            right: 5,
                            child: _buildSmallCircle(
                                Util.getInitials(widget
                                        .controller
                                        .tokenDetailsEntity
                                        .value
                                        .patientsList?[2]
                                        .patientName ??
                                    'AA'),
                                color: AppColors.primary),
                          ),
                        ],
                      ],
                    ),
                  ),
                  // Cross Icon in top-right
                  Positioned(
                      top: 0,
                      right: 20,
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: AppIcon.closeIcon.widget(
                          height: 24,
                          width: 24,
                        ),
                      )),
                ],
              ),
            ),
            gapH10,
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: AppIcon.swipe.widget()),
                    gapH26,
                    AppText.primary(
                      LocaleKeys.appointmentListScreen_appointment.tr,
                      fontWeight: FontWeightType.semiBold,
                      fontSize: 24,
                    ),
                    gapH10,
                    AppText.primary(
                      "${widget.controller.tokenDetailsEntity.value.tokenShift?.toUpperCase()} / ${widget.controller.tokenDetailsEntity.value.tokenBookedDate?.toFormattedDate()}",
                      fontWeight: FontWeightType.semiBold,
                      color: AppColors.grey60,
                      fontSize: 14,
                    ),
                    gapH10,
                    Expanded(
                        child: ListView.builder(
                      itemCount: widget.controller.tokenDetailsEntity.value
                              .patientsList?.length ??
                          0,
                      itemBuilder: (context, index) {
                        bool isExpanded = selectedIndex == index;
                        var patient = widget.controller.tokenDetailsEntity.value
                            .patientsList?[index];
                        final prescription = patient?.prescription;

                        // Only set from prescription if user hasn't manually picked/uploaded an image
                        if (prescription != null &&
                            prescription.isNotEmpty &&
                            pickedImage.value == null &&
                            uploadedImageUrl.value.isEmpty) {
                          // Check if prescription is a URL or local file path
                          if (prescription.startsWith('http')) {
                            uploadedImageUrl.value = prescription;
                          } else {
                            pickedImage.value = File(prescription);
                          }
                        }
                        return Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Column(
                              children: [
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(70),
                                      color: AppColors.initialsListColor,
                                    ),
                                    child: Center(
                                        child: AppText.primary(
                                      Util.getInitials(
                                          patient?.patientName ?? 'AA'),
                                      fontWeight: FontWeightType.medium,
                                      fontSize: 16,
                                      color: AppColors.grey60,
                                    )),
                                  ),
                                  title: AppText.primary(
                                    patient?.patientName ?? '',
                                    color: AppColors.black,
                                    fontWeight: FontWeightType.medium,
                                    fontSize: 16,
                                  ),
                                  trailing: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    child: isExpanded
                                        ? AppIcon.dropUp.widget()
                                        : AppIcon.dropDown.widget(),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      if (isExpanded) {
                                        selectedIndex = null;
                                      } else {
                                        selectedIndex = index;
                                      }
                                    });
                                  },
                                ),
                                gapH10,
                                if (isExpanded) ...[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            AppText.primary(
                                              LocaleKeys
                                                  .appointmentScreen_tokenNumber
                                                  .tr,
                                              fontWeight:
                                                  FontWeightType.regular,
                                              fontSize: 14,
                                            ),
                                            AppText.primary(
                                              '#${widget.controller.tokenDetailsEntity.value.tokenNumber}',
                                              fontWeight:
                                                  FontWeightType.regular,
                                              fontSize: 14,
                                            ),
                                          ],
                                        ),
                                        gapH14,
                                        const Divider(
                                          height: 1,
                                          color: AppColors.grey80,
                                        ),
                                        gapH14,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            AppText.primary(
                                              LocaleKeys
                                                  .appointmentScreen_noOfPatients
                                                  .tr,
                                              fontWeight:
                                                  FontWeightType.regular,
                                              fontSize: 14,
                                            ),
                                            AppText.primary(
                                              widget
                                                  .controller
                                                  .tokenDetailsEntity
                                                  .value
                                                  .numberOfPatients
                                                  .toString(),
                                              fontWeight:
                                                  FontWeightType.regular,
                                              fontSize: 14,
                                            ),
                                          ],
                                        ),
                                        gapH14,
                                        const Divider(
                                          height: 1,
                                          color: AppColors.grey80,
                                        ),
                                        gapH14,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            AppText.primary(
                                              LocaleKeys
                                                  .appointmentListScreen_patientAge
                                                  .tr,
                                              fontSize: 14,
                                              fontWeight:
                                                  FontWeightType.regular,
                                            ),
                                            AppText.primary(
                                              '${patient?.patientAge} ${LocaleKeys.appointmentListScreen_years.tr}',
                                              fontSize: 14,
                                              fontWeight:
                                                  FontWeightType.regular,
                                            ),
                                          ],
                                        ),
                                        gapH14,
                                        const Divider(
                                          height: 1,
                                          color: AppColors.grey80,
                                        ),
                                        gapH14,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            AppText.primary(
                                              LocaleKeys
                                                  .appointmentListScreen_gender
                                                  .tr,
                                              fontSize: 14,
                                              fontWeight:
                                                  FontWeightType.regular,
                                            ),
                                            AppText.primary(
                                              patient?.patientGender ?? '',
                                              fontSize: 14,
                                              fontWeight:
                                                  FontWeightType.regular,
                                            ),
                                          ],
                                        ),
                                        gapH14,
                                        const Divider(
                                          height: 1,
                                          color: AppColors.grey80,
                                        ),
                                        gapH14,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            AppText.primary(
                                              LocaleKeys
                                                  .appointmentListScreen_status
                                                  .tr,
                                              fontSize: 14,
                                            ),
                                            RoundBorderButton(
                                              width: 70,
                                              height: 20,
                                              color: AppColors.checkedColor,
                                              textColor: AppColors.white,
                                              title: widget
                                                      .controller
                                                      .tokenDetailsEntity
                                                      .value
                                                      .status
                                                      ?.capitalizeFirstLetter() ??
                                                  '',
                                              fontSize: 10,
                                              onPressed: () {},
                                            ),
                                          ],
                                        ),
                                        gapH14,
                                        if (widget.controller.userRole.value ==
                                                UserRole.patient ||
                                            (widget.controller.userRole.value ==
                                                    UserRole.doctor &&
                                                (pickedImage.value != null ||
                                                    uploadedImageUrl.value
                                                        .isNotEmpty))) ...[
                                          GestureDetector(
                                            onTap: () {
                                              _showImagePickerOptions(context);
                                            },
                                            child: DottedBorder(
                                              color: AppColors.pickFileDotColor,
                                              strokeWidth: 2,
                                              dashPattern: const [6, 4],
                                              borderType: BorderType.RRect,
                                              radius: const Radius.circular(12),
                                              child: Container(
                                                height: 350,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: AppColors
                                                      .pickFileBoxColor,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Center(
                                                  child: uploadedImageUrl.value
                                                              .isNotEmpty
                                                      ? ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          child: Image.network(
                                                            uploadedImageUrl
                                                                .value,
                                                            fit: BoxFit.cover,
                                                            height:
                                                                double.infinity,
                                                            width:
                                                                double.infinity,
                                                            errorBuilder:
                                                                (context, error,
                                                                    stackTrace) {
                                                              return const Icon(Icons
                                                                  .image_not_supported);
                                                            },
                                                          ),
                                                        )
                                                      : pickedImage.value !=
                                                              null
                                                          ? ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                              child: Image.file(
                                                                pickedImage
                                                                    .value!,
                                                                fit: BoxFit
                                                                    .cover,
                                                                height: double
                                                                    .infinity,
                                                                width: double
                                                                    .infinity,
                                                              ),
                                                            )
                                                          : Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                AppIcon
                                                                    .uploadIcon
                                                                    .widget(
                                                                        height:
                                                                            66,
                                                                        width:
                                                                            66),
                                                                gapH12,
                                                                AppText.primary(
                                                                  LocaleKeys
                                                                      .appointmentListScreen_uploadPrescription
                                                                      .tr,
                                                                  fontWeight:
                                                                      FontWeightType
                                                                          .bold,
                                                                ),
                                                              ],
                                                            ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          gapH14,
                                        ]
                                      ],
                                    ),
                                  ),
                                ],
                                const Divider(
                                  height: 1,
                                  color: AppColors.grey80,
                                ),
                              ],
                            ));
                      },
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text(LocaleKeys.appointmentListScreen_gallery.tr),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: Text(LocaleKeys.appointmentListScreen_camera.tr),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBigCircle(String initials) {
    return Container(
      height: 100,
      width: 100,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.white,
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

  Widget _buildSmallCircle(String initials,
      {double size = 50, Color color = AppColors.patientInitialColor}) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: AppColors.white, width: 2),
      ),
      child: Center(
        child: AppText.primary(
          initials,
          fontSize: 16,
          color: AppColors.white,
          fontWeight: FontWeightType.bold,
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final isGranted = await _requestPermissions(source);

    if (!isGranted) {
      print('Permission denied');
      return;
    }

    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        // Immediately show the picked local image
        setState(() {
          pickedImage.value = File(pickedFile.path);
          uploadedImageUrl.value = ''; // Clear any previous uploaded URL
        });

        // Upload the image
        widget.controller.uploadPrescription(
          imagePath: pickedFile.path,
          onSuccess: (path) {
            print("Prescription uploaded to: $path");
            setState(() {
              // Store the uploaded URL and clear local file
              uploadedImageUrl.value = path;
              pickedImage.value = null;
            });
          },
        );
      } else {
        print('User cancelled image picking.');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<bool> _requestPermissions(ImageSource source) async {
    if (Platform.isAndroid) {
      if (source == ImageSource.camera) {
        final status = await Permission.camera.request();
        return status.isGranted;
      } else {
        // Android 13+ uses READ_MEDIA_IMAGES
        if (await Permission.photos.isGranted ||
            await Permission.storage.isGranted) return true;

        final status = await Permission.photos.request();
        if (status.isGranted) return true;

        final legacyStatus = await Permission.storage.request();
        return legacyStatus.isGranted;
      }
    } else if (Platform.isIOS) {
      final status = source == ImageSource.camera
          ? await Permission.camera.request()
          : await Permission.photos.request();
      return status.isGranted;
    }
    return false;
  }
}
