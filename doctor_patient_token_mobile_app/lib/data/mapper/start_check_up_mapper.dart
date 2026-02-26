import 'package:doctor_patient_token_mobile_app/data/api/response/start_check_up_response.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/start_check_up_entity.dart';

class StartCheckUpMapper {
  static StartCheckUpEntity toStartCheckUpEntity(StartCheckUpResponse startCheckUpResponse) {
    return StartCheckUpEntity(
      shift: startCheckUpResponse.shift,
      date: startCheckUpResponse.date,
    );
  }
}