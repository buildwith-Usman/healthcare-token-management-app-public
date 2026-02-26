import 'package:doctor_patient_token_mobile_app/domain/entity/current_token_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/repositories/token_booking_repository.dart';

import 'base_usecase.dart';

class CurrentTokenUseCase implements NoParamUseCase<CurrentTokenEntity?> {
  final TokenBookingRepository tokenBookingRepository;

  CurrentTokenUseCase({required this.tokenBookingRepository});

  @override
  Future<CurrentTokenEntity?> execute() async {
    final currentTokenEntity = await tokenBookingRepository.getCurrentToken();
    return currentTokenEntity;
  }

}
