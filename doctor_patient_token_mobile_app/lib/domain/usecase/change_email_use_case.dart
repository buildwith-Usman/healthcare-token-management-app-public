import 'package:doctor_patient_token_mobile_app/domain/entity/change_email_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/repositories/user_repository.dart';

import '../../data/api/request/change_email_request.dart';
import 'base_usecase.dart';

class ChangeEmailUseCase implements ParamUseCase<ChangeEmailEntity?,ChangeEmailRequest> {
  final UserRepository userRepository;

  ChangeEmailUseCase({required this.userRepository});

  @override
  Future<ChangeEmailEntity?> execute(ChangeEmailRequest params) async {
    final changeEmailEntity = await userRepository.changeEmail(params);
    return changeEmailEntity;
  }

}
