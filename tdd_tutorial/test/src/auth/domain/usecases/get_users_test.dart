import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/src/auth/domain/entities/user.dart';
import 'package:tdd_tutorial/src/auth/domain/repositories/auth_repo.dart';
import 'package:tdd_tutorial/src/auth/domain/usecases/get_users.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late GetUsers usecase;
  late AuthRepository repository;

  setUp(() {
    repository = MockAuthRepository();
    usecase = GetUsers(repository);
  });

  const listUser = [User.empty()];

  test("Should call the [AuthRepository.getUsers] and return [List<User>]",
      () async {
    // Arrange
    // STUB
    when(() => repository.getUsers())
        .thenAnswer((_) async => const Right(listUser));

    // Act
    final result = await usecase();

    // Assert
    expect(result, equals(const Right<dynamic, List<User>>(listUser)));
    verify(() => repository.getUsers()).called(1);
    verifyNoMoreInteractions(repository);
  });
}
