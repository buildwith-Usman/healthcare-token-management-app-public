import 'package:doctor_patient_token_mobile_app/domain/entity/user_entity.dart';

class LoginEntity {
  const LoginEntity({
    required this.user,
    required this.token,
    required this.tokenType,
  });

  final UserEntity user;
  final String token;
  final String tokenType;
}
