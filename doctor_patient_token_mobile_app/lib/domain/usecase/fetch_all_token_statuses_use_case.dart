import 'package:doctor_patient_token_mobile_app/domain/entity/token_status_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/repositories/token_booking_repository.dart';

import 'base_usecase.dart';

class FetchAllTokenStatusesUseCase implements NoParamUseCase<TokenStatusEntity?> {

  final TokenBookingRepository tokenBookingRepository;

  FetchAllTokenStatusesUseCase({required this.tokenBookingRepository});

  @override
  Future<TokenStatusEntity?> execute() async {
    final tokenStatusEntity = await tokenBookingRepository.fetchAllTokenStatus();
    return tokenStatusEntity;
  }

}
