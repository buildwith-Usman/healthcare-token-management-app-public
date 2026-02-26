import 'package:doctor_patient_token_mobile_app/data/api/request/checked_patient_request.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/checked_token_entity.dart';

import '../repositories/token_booking_repository.dart';
import 'base_usecase.dart';

class CheckedTokenUseCase
    implements ParamUseCase<CheckedTokenEntity?, CheckedPatientRequest> {
  final TokenBookingRepository tokenBookingRepository;

  CheckedTokenUseCase({required this.tokenBookingRepository});

  @override
  Future<CheckedTokenEntity?> execute(CheckedPatientRequest params) async {
    final checkedTokenEntity =
        await tokenBookingRepository.checkedToken(params);
    return checkedTokenEntity;
  }
}
