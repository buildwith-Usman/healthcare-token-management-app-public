import 'package:dio/dio.dart';

class BaseErrorResponse {
  BaseErrorResponse({
    required this.statusCode,
    required this.statusMessage,
    this.errorCode,
  });

  /// The HTTP status code for the response.
  ///
  /// This can be null if the response was constructed manually.
  int? statusCode;

  /// Returns the reason phrase associated with the status code.
  String? statusMessage;

  /// Error code
  String? errorCode;

  factory BaseErrorResponse.unknownError() =>
      BaseErrorResponse(statusCode: 400, statusMessage: 'Unknown Error');

  factory BaseErrorResponse.fromDioException(DioException exception) {
    try {
      Map<String, dynamic> error = exception.response?.data;
      final message = error['jlMessageFormat'];
      return BaseErrorResponse(
        statusCode: exception.response?.statusCode ?? 400,
        statusMessage: message ?? 'Unknown Error',
      );
    } catch (e) {
      return BaseErrorResponse(
        statusCode: exception.response?.statusCode ?? 400,
        statusMessage: exception.response?.statusMessage ?? 'Unknown Error',
      );
    }
  }

  factory BaseErrorResponse.handleErrorResponse(DioException exception) {
    try {
      final data = exception.response?.data;

      if (data is Map<String, dynamic>) {
        return BaseErrorResponse(
          statusCode: exception.response?.statusCode ?? 400,
          statusMessage: data['message'] ??
              (data['errors']?.values?.first is String
                  ? data['errors']?.values?.first
                  : 'Unknown Error'),
          errorCode: data['errorCode'] ?? '',
        );
      } else {
        return BaseErrorResponse(
          statusCode: exception.response?.statusCode ?? 400,
          statusMessage: exception.response?.statusMessage ?? 'Unknown Error',
        );
      }
    } catch (e) {
      return BaseErrorResponse(
        statusCode: exception.response?.statusCode ?? 400,
        statusMessage: exception.response?.statusMessage ?? 'Unknown Error',
      );
    }
  }
}
