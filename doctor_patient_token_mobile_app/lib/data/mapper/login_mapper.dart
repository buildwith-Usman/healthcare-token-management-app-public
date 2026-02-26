import '../../domain/entity/login_entity.dart';
import '../../domain/entity/user_entity.dart';
import '../api/response/login_response.dart';

class LoginMapper {
  static LoginEntity toLoginEntity(LoginResponse loginResponse) {
    return LoginEntity(
      user: UserEntity(
        id: loginResponse.user.id,
        name: loginResponse.user.name,
        email: loginResponse.user.email,
        status: loginResponse.user.status,
        level: loginResponse.user.level,
        phone: loginResponse.user.phone,
      ),
      token: loginResponse.token,
      tokenType: loginResponse.tokenType,
    );
  }
}