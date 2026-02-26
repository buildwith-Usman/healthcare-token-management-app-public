import '../../domain/entity/error_entity.dart';
import '../api/response/error_response.dart';

class ExceptionMapper {
  static BaseErrorEntity toBaseErrorEntity(BaseErrorResponse error) {
    return BaseErrorEntity(
      statusCode: error.statusCode,
      message: error.statusMessage,
      errorCode: error.errorCode,
    );
  }
}
