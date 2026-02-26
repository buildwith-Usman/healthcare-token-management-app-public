import '../../data/api/response/current_token_response.dart';
import '../../domain/entity/current_token_entity.dart';

class CurrentTokenMapper {
  static CurrentTokenEntity toCurrentTokenEntity(CurrentTokenResponse response) {
    return CurrentTokenEntity(token: response.token);
  }
}
