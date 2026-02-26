import 'package:doctor_patient_token_mobile_app/presentation/appointment_confirm/appointment_confirm_binding.dart';
import 'package:doctor_patient_token_mobile_app/presentation/appointment_confirm/appointment_confirm_page.dart';
import 'package:doctor_patient_token_mobile_app/presentation/appointments/detail_appointment_page.dart';
import 'package:doctor_patient_token_mobile_app/presentation/choosepass/choose_pass_binding.dart';
import 'package:doctor_patient_token_mobile_app/presentation/choosepass/choose_pass_page.dart';
import 'package:doctor_patient_token_mobile_app/presentation/congratulation/congo_binding.dart';
import 'package:doctor_patient_token_mobile_app/presentation/congratulation/congo_page.dart';
import 'package:doctor_patient_token_mobile_app/presentation/forgetpass/forget_pass_page.dart';
import 'package:doctor_patient_token_mobile_app/presentation/login_page/login_binding.dart';
import 'package:doctor_patient_token_mobile_app/presentation/login_page/login_page.dart';
import 'package:doctor_patient_token_mobile_app/presentation/navigation/nav_binding.dart';
import 'package:doctor_patient_token_mobile_app/presentation/navigation/navigation_screen.dart';
import 'package:doctor_patient_token_mobile_app/presentation/otp/otp_binding.dart';
import 'package:doctor_patient_token_mobile_app/presentation/otp/otp_page.dart';
import 'package:doctor_patient_token_mobile_app/presentation/patientDetails/patient_details_binding.dart';
import 'package:doctor_patient_token_mobile_app/presentation/patientDetails/patient_details_page.dart';
import 'package:doctor_patient_token_mobile_app/presentation/signup_screen/signup_binding.dart';
import 'package:doctor_patient_token_mobile_app/presentation/signup_screen/signup_page.dart';
import 'package:doctor_patient_token_mobile_app/presentation/start_page/start_binding.dart';
import 'package:doctor_patient_token_mobile_app/presentation/start_page/start_page.dart';
import 'package:get/get.dart';

import '../../presentation/appointments/detail_appointment_binding.dart';
import '../../presentation/forgetpass/forget_pass_binding.dart';
import '../../presentation/splash/splash_binding.dart';
import '../../presentation/splash/splash_page.dart';
import 'app_routes.dart';

class AppPages {
  static const appInitialRoute = AppRoutes.splash;

  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
      binding:SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.start,
      page: () => const StartPage(),
      binding: StartBinding(),
    ),
    GetPage(
      name: AppRoutes.logIn,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => const SignupPage(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: AppRoutes.forgetPass,
      page: () => const ForgetPassPage(),
      binding: ForgetPassBinding(),
    ),
    GetPage(
      name: AppRoutes.otp,
      page: () => const OtpPage(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: AppRoutes.chosePass,
      page: () => const ChoosePassPage(),
      binding: ChoosePassBinding(),
    ),
    GetPage(
      name: AppRoutes.congoPage,
      page: () => const CongoPage(),
      binding: CongoBinding(),
    ),
    GetPage(
      name: AppRoutes.navScreen,
      page: () =>  const NavigationScreen(),
      binding: NavBinding(),
    ),
    GetPage(
      name: AppRoutes.appointmentConfirm,
      page: () =>  const AppointmentConfirmPage(),
      binding: AppointmentConfirmBinding(),
    ),
    GetPage(
      name: AppRoutes.appointmentDetails,
      page: () =>  const DetailAppointmentPage(),
      binding: DetailAppointmentBinding(),
    ),
    GetPage(
      name: AppRoutes.patientDetails,
      page: () =>  const PatientDetailsPage(),
      binding: PatientDetailsBinding(),
    ),
  ];
}
