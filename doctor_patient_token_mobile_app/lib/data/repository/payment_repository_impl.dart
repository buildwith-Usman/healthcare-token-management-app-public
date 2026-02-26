import 'package:doctor_patient_token_mobile_app/data/datasource/payment/payment_datasource.dart';
import 'package:doctor_patient_token_mobile_app/domain/repositories/payment_repository.dart';



class PaymentRepositoryImpl extends PaymentRepository {
  PaymentRepositoryImpl({required this.paymentDatasource});

  final PaymentDatasource paymentDatasource;


}
