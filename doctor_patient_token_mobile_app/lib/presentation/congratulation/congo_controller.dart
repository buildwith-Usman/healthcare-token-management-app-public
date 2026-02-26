import '../../app/config/app_constant.dart';
import '../../app/config/app_routes.dart';
import '../../di/client_module.dart';
import 'package:get/get.dart';

class CongoController extends GetxController with ClientModule {

  final RxString screenOpenedFrom = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>;
    screenOpenedFrom.value = args[Arguments.openedFrom].toString();
  }

  void goToLogin() {
    Get.offAllNamed(AppRoutes.logIn);
  }

}
