import 'package:dartz/dartz.dart';
import 'package:tdd_tutorial/core/errors/exceptions.dart';
import 'package:tdd_tutorial/core/errors/failure.dart';
import 'package:tdd_tutorial/core/utils/typedef.dart';
import 'package:tdd_tutorial/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:tdd_tutorial/src/auth/domain/entities/user.dart';
import 'package:tdd_tutorial/src/auth/domain/repositories/auth_repo.dart';

class AuthRepositoryImplementation implements AuthRepository {
  const AuthRepositoryImplementation(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  ResultVoid createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    try {
      await _remoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    try {
      final userListData = await _remoteDataSource.getUsers();
      return Right(userListData);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
