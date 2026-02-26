import 'package:doctor_patient_token_mobile_app/data/api/request/sign_up_request.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/sign_up_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/repositories/auth_repository.dart';

import 'base_usecase.dart';

class SignUpUseCase implements ParamUseCase<SignUpEntity?, SignUpRequest> {
  final AuthRepository repository;

  SignUpUseCase({required this.repository});

  @override
  Future<SignUpEntity?> execute(SignUpRequest params) async {
    final signUpEntity = await repository.signUp(params);
    return signUpEntity;
  }
}
