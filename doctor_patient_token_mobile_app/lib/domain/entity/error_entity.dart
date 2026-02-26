class BaseErrorEntity {
  BaseErrorEntity({
    required this.statusCode,
    required this.message,
    this.errorCode,
  });

  final int? statusCode;
  final String? message;
  final String? errorCode;

  factory BaseErrorEntity.noNetworkError() => BaseErrorEntity(
      statusCode: 0,
      message: 'You will need an internet connection to continue.');

  factory BaseErrorEntity.noData() =>
      BaseErrorEntity(statusCode: 1, message: 'No data.');
}
