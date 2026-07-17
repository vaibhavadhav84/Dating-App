// lib/features/home/domain/repositories/user_repository.dart
import '../entities/user_entity.dart';
import '../../../../core/error/failures.dart';

abstract class UserRepository {
  Future<(List<UserEntity>?, Failure?)> getUsers({int results = 20});
  Future<(List<UserEntity>?, Failure?)> getUsersPage({
    required int page,
    int results = 20,
  });
}
