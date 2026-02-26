import 'package:doctor_patient_token_mobile_app/presentation/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_links/app_links.dart';

import '../../../app/config/app_colors.dart';
import '../../app/config/app_icon.dart';
import '../../generated/locales.g.dart';
import '../widgets/app_text.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SplashController controller = Get.find<SplashController>();
  late final AppLinks _appLinks;

  @override
  void initState() {
    super.initState();
    _appLinks = AppLinks();
    _initDeepLinks();
  }

  void _initDeepLinks() {
    // For cold start
    _appLinks.getInitialAppLink().then((uri) {
      if (uri != null) {
        _handleIncomingLink(uri);
      }
    });

    // For app already running
    _appLinks.uriLinkStream.listen((uri) {
      _handleIncomingLink(uri);
    });
  }

  void _handleIncomingLink(Uri uri) {
    if (uri.scheme == 'imc' && uri.host == 'payment-success') {
      // Navigate to your home/dashboard page
      controller.goToSplash(); // Change '/home' to your actual route if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Obx(() {
        if (!controller.isConnected.value) {
          return _noInternetWidget();
        }
        return _buildSplashContent();
      }),
    );
  }

  Widget _buildSplashContent() {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcon.icAppIcon.widget(),
                const SizedBox(height: 10),
                AppText.primary(
                  LocaleKeys.app_name.tr,
                  fontSize: 14,
                  color: AppColors.white,
                ),
                const SizedBox(height: 20),
                Obx(() => CircularProgressIndicator(
                      value: controller.lnProgressValue.value,
                      color: AppColors.white,
                      backgroundColor: Colors.white.withOpacity(0.3),
                    )),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 60),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText.primary(
                'Credits to',
                fontSize: 12,
                color: AppColors.white.withOpacity(0.8),
                fontWeight: FontWeightType.regular,
              ),
              const SizedBox(height: 4),
              AppText.primary(
                'Umar Maqsood',
                fontSize: 14,
                color: AppColors.white,
                fontWeight: FontWeightType.medium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _noInternetWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() => controller.isCheckingConnection.value
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : const Icon(Icons.wifi_off, size: 60, color: Colors.white)),
          const SizedBox(height: 16),
          Obx(() => AppText.primary(
                controller.isCheckingConnection.value
                    ? 'Checking Connection...'
                    : 'No Internet Connection',
                color: AppColors.white,
                fontSize: 18,
              )),
          const SizedBox(height: 8),
          Obx(() => AppText.primary(
                controller.isCheckingConnection.value
                    ? 'Please wait...'
                    : 'Please check your connection and try again.',
                color: AppColors.white.withOpacity(0.8),
                fontSize: 14,
                textAlign: TextAlign.center,
              )),
          const SizedBox(height: 24),
          Obx(() => ElevatedButton(
                onPressed: controller.isCheckingConnection.value
                    ? null
                    : () {
                        controller.retryConnection();
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primary,
                  disabledBackgroundColor: Colors.white.withOpacity(0.5),
                  disabledForegroundColor: AppColors.primary.withOpacity(0.5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Retry'),
              )),
        ],
      ),
    );
  }
}
