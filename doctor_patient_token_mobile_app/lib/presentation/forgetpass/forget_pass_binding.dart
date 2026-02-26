
import 'package:doctor_patient_token_mobile_app/domain/usecase/forgot_password_use_case.dart';

import '../../di/client_module.dart';
import '../../di/config_module.dart';
import '../../di/datasource_module.dart';
import '../../di/repository_module.dart';
import 'forget_pass_controller.dart';
import 'package:get/get.dart';


class ForgetPassBinding extends Bindings with ClientModule, DatasourceModule, RepositoryModule, ConfigModule  {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgetPassController(
      forgotPasswordUseCase: ForgotPasswordUseCase(repository: authRepository),
    ));
  }


}
