import 'package:doctor_patient_token_mobile_app/presentation/doctor_dashboard/filter_bottom_sheet_controller.dart';
import 'package:get/get.dart';

import '../../di/client_module.dart';
import '../../di/config_module.dart';
import '../../di/datasource_module.dart';
import '../../di/repository_module.dart';

class FilterBottomSheetBinding extends Bindings
    with ClientModule, DatasourceModule, RepositoryModule, ConfigModule {
  @override
  void dependencies() {
    Get.lazyPut(() => FilterBottomSheetController());
  }
}
