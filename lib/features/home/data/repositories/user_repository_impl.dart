// lib/features/home/data/repositories/user_repository_impl.dart
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_datasource.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDatasource remoteDatasource;

  const UserRepositoryImpl({required this.remoteDatasource});

  @override
  Future<(List<UserEntity>?, Failure?)> getUsers({int results = 20}) async {
    try {
      final models = await remoteDatasource.getUsers(results: results);
      return (models.map((m) => m.toEntity()).toList(), null);
    } on ServerException catch (e) {
      return (null, ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return (null, NetworkFailure(message: e.message));
    } on TimeoutException catch (e) {
      return (null, ConnectionFailure(message: e.message));
    } catch (e) {
      return (null, UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<(List<UserEntity>?, Failure?)> getUsersPage({
    required int page,
    int results = 20,
  }) async {
    try {
      final models = await remoteDatasource.getUsersPage(
        page: page,
        results: results,
      );
      return (models.map((m) => m.toEntity()).toList(), null);
    } on ServerException catch (e) {
      return (null, ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return (null, NetworkFailure(message: e.message));
    } on TimeoutException catch (e) {
      return (null, ConnectionFailure(message: e.message));
    } catch (e) {
      return (null, UnknownFailure(message: e.toString()));
    }
  }
}
