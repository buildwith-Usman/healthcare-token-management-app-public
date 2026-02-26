import 'package:doctor_patient_token_mobile_app/domain/usecase/change_email_use_case.dart';
import 'package:doctor_patient_token_mobile_app/domain/usecase/change_phone_use_case.dart';
import 'package:doctor_patient_token_mobile_app/presentation/settings/change_profile_controller.dart';
import 'package:get/get.dart';

import '../../di/client_module.dart';
import '../../di/config_module.dart';
import '../../di/datasource_module.dart';
import '../../di/repository_module.dart';

class ChangeProfileBinding extends Bindings with ClientModule, DatasourceModule, RepositoryModule, ConfigModule {

  @override
  void dependencies() {
   Get.lazyPut(() => ChangeProfileController(changeEmailUseCase:ChangeEmailUseCase(userRepository: userRepository), changePhoneUseCase: ChangePhoneUseCase(userRepository: userRepository)));
  }

}