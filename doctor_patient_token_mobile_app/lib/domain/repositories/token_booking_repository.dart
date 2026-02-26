
import 'package:doctor_patient_token_mobile_app/data/api/request/checked_patient_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/reserve_token_request.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/checked_token_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/reserve_token_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/start_check_up_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/token_status_entity.dart';

import '../entity/current_token_entity.dart';

abstract class TokenBookingRepository {

  Future<CurrentTokenEntity?> getCurrentToken();

  Future<TokenStatusEntity?> fetchAllTokenStatus();

  Future<ReserveTokenEntity?> reserveToken(ReserveTokenRequest request);

  Future<CheckedTokenEntity?> checkedToken(CheckedPatientRequest request);

  Future<StartCheckUpEntity?> startCheckUp();

}
