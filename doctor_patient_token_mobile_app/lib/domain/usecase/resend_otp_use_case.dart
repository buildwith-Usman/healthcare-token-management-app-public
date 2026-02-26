import 'package:doctor_patient_token_mobile_app/domain/entity/resend_otp_entity.dart';
import 'package:doctor_patient_token_mobile_app/data/api/request/resend_otp_request.dart';
import 'package:doctor_patient_token_mobile_app/domain/repositories/auth_repository.dart';

import 'base_usecase.dart';

class ResendOtpUseCase implements ParamUseCase<ResendOtpEntity?, ResendOtpRequest> {
  final AuthRepository repository;

  ResendOtpUseCase({required this.repository});

  @override
  Future<ResendOtpEntity?> execute(ResendOtpRequest params) async {
    final entity = await repository.resendOtp(params);
    return entity;
  }
}
