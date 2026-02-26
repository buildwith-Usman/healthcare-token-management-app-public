import 'package:doctor_patient_token_mobile_app/data/api/response/current_shift_response.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/current_shift_entity.dart';

class CurrentShiftMapper {
  static CurrentShiftEntity toCurrentShiftEntity(
      CurrentShiftResponse currentShiftResponse) {
    return CurrentShiftEntity(
      shift: currentShiftResponse.shift,
      date: currentShiftResponse.date,
      bookingEnable: currentShiftResponse.bookingEnable,
      message: currentShiftResponse.message,
      userTokenNumber: currentShiftResponse.userTokenNumber,
      userTokenStatus: currentShiftResponse.userTokenStatus,
      day: currentShiftResponse.day,
      currentShiftDisable: currentShiftResponse.currentShiftDisable,
    );
  }
}
