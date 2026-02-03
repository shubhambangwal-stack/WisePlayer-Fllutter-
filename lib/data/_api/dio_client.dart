import 'package:dio/dio.dart';
import 'package:wise_players/data/_api/api_services/end_points.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late Dio dio;
  factory DioClient() => _instance;
  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    dio.interceptors.add(AppInterceptor());
  }
}

class AppInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 🔐 Add token
    options.headers['Authorization'] = 'Bearer YOUR_TOKEN';

    // 🪵 Log request
    print('➡️ REQUEST: ${options.method} ${options.uri}');
    print('Headers: ${options.headers}');
    print('Body: ${options.data}');

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // 🪵 Log response
    print('✅ RESPONSE [${response.statusCode}]');
    print('Data: ${response.data}');

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('❌ ERROR: ${err.message}');
    print('Status: ${err.response?.statusCode}');
    print('Data: ${err.response?.data}');

    super.onError(err, handler);
  }
}
