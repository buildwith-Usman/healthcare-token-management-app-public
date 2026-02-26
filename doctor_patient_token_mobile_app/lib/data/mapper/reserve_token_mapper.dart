import 'package:doctor_patient_token_mobile_app/data/api/response/reserve_token_response.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/reserve_token_entity.dart';

class ReserveTokenMapper {
  static ReserveTokenEntity toReserveTokenEntity(
      ReserveTokenResponse reserveTokenResponse) {
    return ReserveTokenEntity(
      tokenId: reserveTokenResponse.tokenId,
      status: reserveTokenResponse.status,
      paymentLink: reserveTokenResponse.paymentLink,
    );
  }
}
