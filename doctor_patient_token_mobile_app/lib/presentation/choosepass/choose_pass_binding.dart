import 'package:doctor_patient_token_mobile_app/domain/usecase/create_password_use_case.dart';
import 'package:doctor_patient_token_mobile_app/presentation/choosepass/choose_pass_controller.dart';
import 'package:get/get.dart';

import '../../di/client_module.dart';
import '../../di/config_module.dart';
import '../../di/datasource_module.dart';
import '../../di/repository_module.dart';

class ChoosePassBinding extends Bindings with ClientModule, DatasourceModule, RepositoryModule, ConfigModule {
  @override

  void dependencies() {
    Get.lazyPut(() => ChoosePassController(
        createPasswordUseCase: CreatePasswordUseCase(repository: authRepository)
    ));
  }

}
