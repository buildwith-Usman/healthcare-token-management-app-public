import 'package:doctor_patient_token_mobile_app/app/environments/environment.dart';

extension DevelopmentEnv on Environment {
  static Environment env() {
    return Environment(
      envName: 'DEV',
      baseDomain: 'https://ikrammedicalcenter.online'
    );
  }
}
