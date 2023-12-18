import 'package:get_it/get_it.dart';
import 'package:tdd_tutorial/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:tdd_tutorial/src/auth/data/repositories/auth_repo_implementation.dart';
import 'package:tdd_tutorial/src/auth/domain/repositories/auth_repo.dart';
import 'package:tdd_tutorial/src/auth/domain/usecases/create_user.dart';
import 'package:tdd_tutorial/src/auth/domain/usecases/get_users.dart';
import 'package:tdd_tutorial/src/auth/presentation/cubit/auth_cubit.dart';
import "package:http/http.dart" as http;

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => AuthCubit(createUser: sl(), getUsers: sl()));
  sl.registerLazySingleton(() => CreateUser(sl()));
  sl.registerLazySingleton(() => GetUsers(sl()));
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImplementation(sl()));
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImplement(sl()));
  sl.registerLazySingleton(http.Client.new);
}
