import 'package:doctor_patient_token_mobile_app/data/api/request/create_password_request.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/create_password_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/repositories/auth_repository.dart';

import 'base_usecase.dart';

class CreatePasswordUseCase implements ParamUseCase<CreatePasswordEntity?, CreatePasswordRequest> {
  final AuthRepository repository;

  CreatePasswordUseCase({required this.repository});

  @override
  Future<CreatePasswordEntity?> execute(CreatePasswordRequest params) async {
    final createPasswordEntity = await repository.createPassword(params);
    return createPasswordEntity;
  }
}
