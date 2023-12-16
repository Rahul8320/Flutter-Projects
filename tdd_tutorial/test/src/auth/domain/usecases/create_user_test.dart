// What does the class depend on
// How can we create a fake version of the dependency
// How do we control what our dependencies do

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/src/auth/domain/repositories/auth_repo.dart';
import 'package:tdd_tutorial/src/auth/domain/usecases/create_user.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late CreateUser usecase;
  late AuthRepository repository;

  setUp(() {
    repository = MockAuthRepository();
    usecase = CreateUser(repository);
  });

  const params = CreateUserParams.empty();

  test('should call the [AuthRepository.createUser]', () async {
    // Arrange
    // STUB
    when(
      () => repository.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar')),
    ).thenAnswer((_) async => const Right(null));

    // Act
    final result = await usecase(params);

    // Assert
    expect(result, equals(const Right<dynamic, void>(null)));
    verify(() => repository.createUser(
        createdAt: params.createdAt,
        name: params.name,
        avatar: params.avatar)).called(1);

    verifyNoMoreInteractions(repository);
  });
}
