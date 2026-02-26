import 'package:doctor_patient_token_mobile_app/domain/usecase/update_setting_use_case.dart';
import 'package:doctor_patient_token_mobile_app/presentation/time_update_bottom_sheet/time_update_bottom_sheet_controller.dart';
import 'package:get/get.dart';

import '../../di/client_module.dart';
import '../../di/config_module.dart';
import '../../di/datasource_module.dart';
import '../../di/repository_module.dart';

class TimeUpdateBottomSheetBinding extends Bindings with ClientModule, DatasourceModule, RepositoryModule, ConfigModule{
  @override
  void dependencies() {
    Get.lazyPut(()=> TimeUpdateBottomSheetController(updateSettingUseCase: UpdateSettingUseCase(userRepository: userRepository)));
  }
}