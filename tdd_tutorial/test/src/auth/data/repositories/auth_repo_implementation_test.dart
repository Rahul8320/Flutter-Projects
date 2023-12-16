import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/core/errors/exceptions.dart';
import 'package:tdd_tutorial/core/errors/failure.dart';
import 'package:tdd_tutorial/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:tdd_tutorial/src/auth/data/models/user_model.dart';
import 'package:tdd_tutorial/src/auth/data/repositories/auth_repo_implementation.dart';
import 'package:tdd_tutorial/src/auth/domain/entities/user.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  late AuthRemoteDataSource dataSource;
  late AuthRepositoryImplementation repository;

  setUp(() {
    dataSource = MockAuthRemoteDataSource();
    repository = AuthRepositoryImplementation(dataSource);
  });

  const message = "Internal Server Error";
  const statusCode = 500;

  group("createUser", () {
    const createdAt = "created at 2023";
    const name = "Far From Home Coming";
    const avatar = "SpiderMan";

    test('Should call [RemoteDataSource.createUser] and complete successfully',
        () async {
      // Arrange
      // STUB
      when(() => dataSource.createUser(
              createdAt: any(named: 'createdAt'),
              name: any(named: 'name'),
              avatar: any(named: 'avatar')))
          .thenAnswer((_) async => Future.value());

      // Act
      final result = await repository.createUser(
          createdAt: createdAt, name: name, avatar: avatar);

      // Assert
      expect(result, equals(const Right(null)));
      verify(() => dataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar)).called(1);
      verifyNoMoreInteractions(dataSource);
    });

    test(
        'Returns a [ApiFailure] when the call to remote data source is failed!',
        () async {
      // Arrange
      // STUB
      when(() => dataSource.createUser(
              createdAt: any(named: 'createdAt'),
              name: any(named: 'name'),
              avatar: any(named: 'avatar')))
          .thenThrow(
              const ApiException(message: message, statusCode: statusCode));

      // Act
      final result = await repository.createUser(
          createdAt: createdAt, name: name, avatar: avatar);

      // Assert
      expect(
          result,
          equals(const Left(
              ApiFailure(message: message, statusCode: statusCode))));
      verify(() => dataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar)).called(1);
      verifyNoMoreInteractions(dataSource);
    });
  });

  group("getUsers", () {
    const testUserList = [UserModel.empty()];

    test(
        'Should call [RemoteDataSource.getUsers] and return [List<User>] successfully',
        () async {
      // Arrange
      // STUB
      when(() => dataSource.getUsers())
          .thenAnswer((_) async => Future.value(testUserList));

      // Act
      final result = await repository.getUsers();

      // Assert
      expect(result, equals(const Right<dynamic, List<User>>(testUserList)));
      expect(result, isA<Right<dynamic, List<User>>>());
      verify(() => dataSource.getUsers()).called(1);
      verifyNoMoreInteractions(dataSource);
    });

    test(
        'Returns a [ApiFailure] when the call to remote data source is failed!',
        () async {
      // Arrange
      // STUB
      when(() => dataSource.getUsers()).thenThrow(
          const ApiException(message: message, statusCode: statusCode));

      // Act
      final result = await repository.getUsers();

      // Assert
      expect(
          result,
          equals(const Left(
              ApiFailure(message: message, statusCode: statusCode))));
      verify(() => dataSource.getUsers()).called(1);
      verifyNoMoreInteractions(dataSource);
    });
  });
}
