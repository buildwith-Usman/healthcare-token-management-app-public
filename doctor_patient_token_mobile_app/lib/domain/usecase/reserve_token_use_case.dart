import 'package:doctor_patient_token_mobile_app/data/api/request/reserve_token_request.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/reserve_token_entity.dart';

import '../repositories/token_booking_repository.dart';
import 'base_usecase.dart';

class ReserveTokenUseCase
    implements ParamUseCase<ReserveTokenEntity?, ReserveTokenRequest> {
  final TokenBookingRepository tokenBookingRepository;

  ReserveTokenUseCase({required this.tokenBookingRepository});

  @override
  Future<ReserveTokenEntity?> execute(ReserveTokenRequest params) async {
    final reserveTokenEntity =
        await tokenBookingRepository.reserveToken(params);
    return reserveTokenEntity;
  }
}
