import 'package:doctor_patient_token_mobile_app/data/api/response/fetch_token_status_response.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/token_status_entity.dart';

class TokenStatusMapper {
  static TokenStatusEntity toTokenStatusEntity(
      FetchTokenStatusResponse tokenStatusResponse) {
    return TokenStatusEntity(
        tokens: tokenStatusResponse.tokens
            .map((token) => TokenStatus(
                number: token.number,
                status: token.status,
                numberOfPatients: token.numberOfPatients,
                tokenId: token.tokenId))
            .toList(),
        shift: tokenStatusResponse.shift,
        date: tokenStatusResponse.date,
        day: tokenStatusResponse.day);
  }
}
