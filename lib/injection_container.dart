// lib/injection_container.dart
import 'package:get_it/get_it.dart';
import 'core/network/dio_client.dart';
import 'features/home/data/datasources/user_remote_datasource.dart';
import 'features/home/data/repositories/user_repository_impl.dart';
import 'features/home/domain/repositories/user_repository.dart';
import 'features/home/domain/usecases/get_users_usecase.dart';
import 'features/home/presentation/bloc/home_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> setupDependencies() async {
  // Core
  final dioClient = DioClient();
  dioClient.init();
  sl.registerSingleton<DioClient>(dioClient);

  // Data Sources
  sl.registerLazySingleton<UserRemoteDatasource>(
    () => UserRemoteDatasourceImpl(dioClient: sl()),
  );

  // Repositories
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(remoteDatasource: sl()),
  );

  // Use Cases
  sl.registerLazySingleton<GetUsersUsecase>(
    () => GetUsersUsecase(repository: sl()),
  );
  sl.registerLazySingleton<GetUsersPageUsecase>(
    () => GetUsersPageUsecase(repository: sl()),
  );

  // Blocs — registered as factory (new instance each time)
  sl.registerFactory<HomeBloc>(
    () => HomeBloc(
      getUsersUsecase: sl(),
      getUsersPageUsecase: sl(),
    ),
  );
}
