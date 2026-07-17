// lib/features/home/data/datasources/user_remote_datasource.dart
import 'package:dio/dio.dart';
import '../models/user_model.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';

abstract class UserRemoteDatasource {
  Future<List<UserModel>> getUsers({int results = 20});
  Future<List<UserModel>> getUsersPage({required int page, int results = 20});
}

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  final DioClient dioClient;

  const UserRemoteDatasourceImpl({required this.dioClient});

  @override
  Future<List<UserModel>> getUsers({int results = 20}) async {
    try {
      final response = await dioClient.dio.get(
        ApiEndpoints.usersWithResults(results),
      );
      final List<dynamic> results0 = response.data['results'] as List<dynamic>;
      return results0
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  @override
  Future<List<UserModel>> getUsersPage({
    required int page,
    int results = 20,
  }) async {
    try {
      final response = await dioClient.dio.get(
        ApiEndpoints.usersByPage(page, results),
      );
      final List<dynamic> resultList =
          response.data['results'] as List<dynamic>;
      return resultList
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  Never _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw TimeoutException(message: 'Request timed out. Please retry.');
      case DioExceptionType.connectionError:
        throw NetworkException(message: 'No internet connection.');
      case DioExceptionType.badResponse:
        throw ServerException(
          message: e.message ?? 'Server error occurred',
          statusCode: e.response?.statusCode,
        );
      default:
        throw NetworkException(message: e.message ?? 'Unknown error occurred');
    }
  }
}
