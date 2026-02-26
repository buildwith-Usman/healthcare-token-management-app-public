import 'package:doctor_patient_token_mobile_app/data/repository/appointment_repository_impl.dart';
import 'package:doctor_patient_token_mobile_app/data/repository/auth_repository_impl.dart';
import 'package:doctor_patient_token_mobile_app/data/repository/token_booking_repository_impl.dart';
import 'package:doctor_patient_token_mobile_app/data/repository/user_repository_impl.dart';
import 'package:doctor_patient_token_mobile_app/domain/repositories/appointment_repository.dart';
import 'package:doctor_patient_token_mobile_app/domain/repositories/auth_repository.dart';
import 'package:doctor_patient_token_mobile_app/domain/repositories/token_booking_repository.dart';
import 'package:doctor_patient_token_mobile_app/domain/repositories/user_repository.dart';

import 'datasource_module.dart';

mixin RepositoryModule on DatasourceModule {

  AuthRepository get authRepository {
    return AuthRepositoryImpl(authDatasource: authDatasource);
  }

  UserRepository get userRepository {
    return UserRepositoryImpl(userDatasource: userDataSource);
  }

  TokenBookingRepository get tokenBookingRepository {
    return TokenBookingRepositoryImpl(tokenBookingDatasource: tokenBookingDatasource);
  }

  AppointmentRepository get appointmentRepository {
    return AppointmentRepositoryImpl(appointmentDatasource: appointmentDatasource);
  }

}
