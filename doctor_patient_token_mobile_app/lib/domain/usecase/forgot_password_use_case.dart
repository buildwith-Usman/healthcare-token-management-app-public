import 'package:doctor_patient_token_mobile_app/data/api/request/forgot_password_request.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/forgot_password_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/repositories/auth_repository.dart';

import 'base_usecase.dart';

class ForgotPasswordUseCase implements ParamUseCase<ForgotPasswordEntity?, ForgotPasswordRequest> {
  final AuthRepository repository;

  ForgotPasswordUseCase({required this.repository});

  @override
  Future<ForgotPasswordEntity?> execute(ForgotPasswordRequest params) async {
    final forgotPasswordEntity = await repository.forgotPassword(params);
    return forgotPasswordEntity;
  }
}
