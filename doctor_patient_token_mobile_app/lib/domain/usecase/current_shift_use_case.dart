import 'package:doctor_patient_token_mobile_app/domain/entity/current_shift_entity.dart';
import 'package:doctor_patient_token_mobile_app/domain/repositories/appointment_repository.dart';

import 'base_usecase.dart';

class CurrentShiftUseCase implements NoParamUseCase<CurrentShiftEntity?> {
  final AppointmentRepository appointmentRepository;

  CurrentShiftUseCase({required this.appointmentRepository});

  @override
  Future<CurrentShiftEntity?> execute() async {
    final currentShiftEntity = await appointmentRepository.currentShift();
    return currentShiftEntity;
  }
}
