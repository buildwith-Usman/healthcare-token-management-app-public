
import 'package:doctor_patient_token_mobile_app/data/api/request/checked_patient_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/reserve_token_request.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/current_token_response.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/fetch_token_status_response.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/reserve_token_response.dart';
import 'package:doctor_patient_token_mobile_app/data/api/response/start_check_up_response.dart';

abstract class TokenBookingDatasource {

  Future<CurrentTokenResponse?> getCurrentToken();

  Future<FetchTokenStatusResponse?> fetchAllTokenStatus();

  Future<ReserveTokenResponse?> reserveToken(ReserveTokenRequest request);

  Future<String?> checkedToken(CheckedPatientRequest request);

  Future<StartCheckUpResponse?> startCheckup();

}