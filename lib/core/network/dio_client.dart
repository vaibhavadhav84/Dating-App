// lib/core/network/dio_client.dart
import 'package:dio/dio.dart';
import '../constants/app_constants.dart';

class DioClient {
  DioClient._internal();

  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;

  late final Dio _dio;

  Dio get dio => _dio;

  void init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout:
            const Duration(milliseconds: AppConstants.connectTimeout),
        receiveTimeout:
            const Duration(milliseconds: AppConstants.receiveTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    _addInterceptors();
  }

  void _addInterceptors() {
    _dio.interceptors.addAll([
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
        logPrint: (obj) => debugPrint(obj.toString()),
      ),
      _RetryInterceptor(_dio),
    ]);
  }
}

class _RetryInterceptor extends Interceptor {
  final Dio dio;
  _RetryInterceptor(this.dio);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Allow retry logic to propagate to repository
    super.onError(err, handler);
  }
}

void debugPrint(String msg) {
  // ignore: avoid_print
  print('[DioClient] $msg');
}
