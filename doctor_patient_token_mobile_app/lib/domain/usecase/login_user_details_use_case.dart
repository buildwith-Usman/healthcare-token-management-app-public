import 'package:doctor_patient_token_mobile_app/domain/entity/user_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/repositories/user_repository.dart';

import 'base_usecase.dart';

class LoginUserDetailsUseCase implements NoParamUseCase<UserEntity?> {
  final UserRepository userRepository;

  LoginUserDetailsUseCase({required this.userRepository});

  @override
  Future<UserEntity?> execute() async {
    final loginUserEntity = await userRepository.getLoginUserDetails();
    return loginUserEntity;
  }

}
