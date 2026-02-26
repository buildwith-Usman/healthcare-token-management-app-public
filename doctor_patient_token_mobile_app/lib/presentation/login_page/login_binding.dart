import 'package:doctor_patient_token_mobile_app/di/client_module.dart';
import 'package:doctor_patient_token_mobile_app/domain/usecase/login_use_case.dart';
import 'package:doctor_patient_token_mobile_app/domain/usecase/login_with_google_usecase.dart';
import 'package:doctor_patient_token_mobile_app/presentation/login_page/login_controller.dart';
import 'package:get/get.dart';

import '../../di/config_module.dart';
import '../../di/datasource_module.dart';
import '../../di/repository_module.dart';

class LoginBinding extends Bindings
    with ClientModule, DatasourceModule, RepositoryModule, ConfigModule {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(
          loginUseCase: LoginUseCase(repository: authRepository),
          loginWithGoogleUseCase:
              LoginWithGoogleUseCase(repository: authRepository),
        ));
  }
}
