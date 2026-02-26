import 'package:doctor_patient_token_mobile_app/app/services/app_storage.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/login_request.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/login_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/repositories/auth_repository.dart';

import 'base_usecase.dart';

class LoginUseCase implements ParamUseCase<LoginEntity?, LoginRequest> {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  @override
  Future<LoginEntity?> execute(LoginRequest params) async {
    final loginEntity = await repository.login(params);
    await AppStorage.instance.setAccessToken(loginEntity.token);
    return loginEntity;
  }

}
