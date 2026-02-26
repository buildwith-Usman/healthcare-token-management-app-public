import 'package:doctor_patient_token_mobile_app/domain/usecase/otp_verification_use_case.dart';
import 'package:doctor_patient_token_mobile_app/presentation/otp/otp_controller.dart';
import 'package:get/get.dart';

import '../../di/client_module.dart';
import '../../di/config_module.dart';
import '../../di/datasource_module.dart';
import '../../di/repository_module.dart';
import '../../domain/usecase/resend_otp_use_case.dart';

class OtpBinding extends Bindings
    with ClientModule, DatasourceModule, RepositoryModule, ConfigModule {
  @override
  void dependencies() {
    Get.lazyPut(() => OtpController(
          otpVerificationUseCase:
              OtpVerificationUseCase(repository: authRepository),
          resendOtpUseCase: ResendOtpUseCase(repository: authRepository),
        ));
  }
}
