import 'package:doctor_patient_token_mobile_app/app/environments/environment.dart';

extension ProductionEnv on Environment {
  static Environment env() {
    return Environment(
      envName: 'LIV',
      baseDomain: 'https://replace-your-actual-url-here'
    );
  }
}
