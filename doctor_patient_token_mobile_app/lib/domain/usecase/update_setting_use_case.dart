import 'package:doctor_patient_token_mobile_app/data/api/request/update_time_setting_request.dart';
import 'package:doctor_patient_token_mobile_app/domain/entity/update_setting_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/repositories/user_repository.dart';

import 'base_usecase.dart';

class UpdateSettingUseCase
    implements ParamUseCase<UpdateSettingEntity?, UpdateTimeSettingRequest> {
  final UserRepository userRepository;

  UpdateSettingUseCase({required this.userRepository});

  @override
  Future<UpdateSettingEntity?> execute(UpdateTimeSettingRequest params) async {
    final updateSettingsEntity = await userRepository.updateSetting(params);
    return updateSettingsEntity;
  }
}
