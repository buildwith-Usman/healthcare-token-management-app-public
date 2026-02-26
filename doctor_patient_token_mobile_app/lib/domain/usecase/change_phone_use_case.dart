import 'package:doctor_patient_token_mobile_app/data/api/request/change_phone_request.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/change_phone_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/repositories/user_repository.dart';

import 'base_usecase.dart';

class ChangePhoneUseCase implements ParamUseCase<ChangePhoneEntity?,ChangePhoneRequest> {
  final UserRepository userRepository;

  ChangePhoneUseCase({required this.userRepository});

  @override
  Future<ChangePhoneEntity?> execute(ChangePhoneRequest params) async {
    final changePhoneEntity = await userRepository.changePhone(params);
    return changePhoneEntity;
  }

}
