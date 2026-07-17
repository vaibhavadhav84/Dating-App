// lib/features/home/domain/usecases/get_users_usecase.dart
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';
import '../../../../core/error/failures.dart';

class GetUsersUsecase {
  final UserRepository repository;

  const GetUsersUsecase({required this.repository});

  Future<(List<UserEntity>?, Failure?)> call({int results = 20}) =>
      repository.getUsers(results: results);
}

class GetUsersPageUsecase {
  final UserRepository repository;

  const GetUsersPageUsecase({required this.repository});

  Future<(List<UserEntity>?, Failure?)> call({
    required int page,
    int results = 20,
  }) =>
      repository.getUsersPage(page: page, results: results);
}
