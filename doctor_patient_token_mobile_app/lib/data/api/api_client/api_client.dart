import 'package:dio/dio.dart';

import 'api_client_type.dart';
import 'interceptor/base_query_interceptor.dart';
import 'interceptor/curl_log.dart';

class APIClient {

  static APIClientType apiClient({
    bool disableRequestBodyLogging = false,
    bool ignoreToken = false,
    bool ignoreConnection = false,
  }) {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 60), // Increased for mobile data
        receiveTimeout: const Duration(seconds: 60), // Increased for mobile data
        sendTimeout: const Duration(seconds: 60), // Increased for mobile data
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );
    dio.interceptors.add(CurlLogInterceptor());
    dio.interceptors.add(BaseQueryInterceptor(
      dio: dio,
      ignoreConnection: ignoreConnection,
      ignoreToken: ignoreToken,
    ));
    return APIClientType(dio, baseUrl: '');
  }

}
