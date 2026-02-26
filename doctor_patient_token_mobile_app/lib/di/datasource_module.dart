import 'package:doctor_patient_token_mobile_app/data/datasource/appointment/appointment_datasource.dart';
import 'package:doctor_patient_token_mobile_app/data/datasource/auth/auth_datasource.dart';
import 'package:doctor_patient_token_mobile_app/data/datasource/auth/auth_datasource_impl.dart';
import 'package:doctor_patient_token_mobile_app/data/datasource/payment/payment_datasource.dart';
import 'package:doctor_patient_token_mobile_app/data/datasource/payment/payment_datasource_impl.dart';
import 'package:doctor_patient_token_mobile_app/data/datasource/tokenBooking/token_booking_datasource.dart';
import 'package:doctor_patient_token_mobile_app/data/datasource/tokenBooking/token_booking_datasource_impl.dart';
import 'package:doctor_patient_token_mobile_app/data/datasource/user/user_datasource.dart';
import 'package:doctor_patient_token_mobile_app/data/datasource/user/user_datasource_impl.dart';
import '../data/datasource/appointment/appointment_datasource_impl.dart';
import 'client_module.dart';

mixin DatasourceModule on ClientModule {

  AuthDatasource get authDatasource {
    return AuthDatasourceImpl(unauthenticatedClient: unauthenticatedClient);
  }

  UserDatasource get userDataSource {
    return UserDatasourceImpl(apiClient: apiClient);
  }

  AppointmentDatasource get appointmentDatasource {
    return AppointmentDatasourceImpl(apiClient: apiClient);
  }

  TokenBookingDatasource get tokenBookingDatasource {
    return TokenBookingDatasourceImpl(apiClient: apiClient);
  }

  PaymentDatasource get paymentDatasource {
    return PaymentDatasourceImpl(apiClient: apiClient);
  }

}
