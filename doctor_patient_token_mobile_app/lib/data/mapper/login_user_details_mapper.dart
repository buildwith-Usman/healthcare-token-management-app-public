import 'package:doctor_patient_token_mobile_app/data/api/response/user_response.dart';

import '../../domain/entity/user_entity.dart';

class LoginUserDetailsMapper {
  static UserEntity toUserLoginEntity(UserResponse userResponse) {
    return UserEntity(
      id: userResponse.id,
      name: userResponse.name,
      email: userResponse.email,
      status: userResponse.status,
      level: userResponse.level,
      phone: userResponse.phone,
    );
  }
}