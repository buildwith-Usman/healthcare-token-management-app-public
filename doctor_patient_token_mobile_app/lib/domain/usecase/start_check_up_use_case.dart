import 'package:doctor_patient_token_mobile_app/domain/entity/start_check_up_entity.dart';

import '../repositories/token_booking_repository.dart';
import 'base_usecase.dart';

class StartCheckUpUseCase
    implements NoParamUseCase<StartCheckUpEntity?> {
  final TokenBookingRepository tokenBookingRepository;

  StartCheckUpUseCase({required this.tokenBookingRepository});

  @override
  Future<StartCheckUpEntity?> execute() async {
    final startCheckUpEntity =
        await tokenBookingRepository.startCheckUp();
    return startCheckUpEntity;
  }
}
