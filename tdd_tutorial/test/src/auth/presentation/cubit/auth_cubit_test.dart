import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/core/errors/failure.dart';
import 'package:tdd_tutorial/src/auth/data/models/user_model.dart';
import 'package:tdd_tutorial/src/auth/domain/usecases/create_user.dart';
import 'package:tdd_tutorial/src/auth/domain/usecases/get_users.dart';
import 'package:tdd_tutorial/src/auth/presentation/cubit/auth_cubit.dart';

class MockGetUsers extends Mock implements GetUsers {}

class MockCreateUser extends Mock implements CreateUser {}

void main() {
  late GetUsers getUsers;
  late CreateUser createUser;
  late AuthCubit cubit;

  const testCreateUserParams = CreateUserParams.empty();
  const testApiFailure = ApiFailure(message: 'Bad Request', statusCode: 400);

  setUp(() {
    getUsers = MockGetUsers();
    createUser = MockCreateUser();
    cubit = AuthCubit(createUser: createUser, getUsers: getUsers);
    registerFallbackValue(testCreateUserParams);
  });

  tearDown(() => cubit.close());

  test('initial state should be [AuthInitial]', () async {
    // Assert
    expect(cubit.state, const AuthInitial());
  });

  group('createUser', () {
    blocTest<AuthCubit, AuthState>(
      'should emits [CreatingUser, UserCreated] when successfull.',
      build: () {
        when(() => createUser(any())).thenAnswer(
          (_) async => const Right(null),
        );
        return cubit;
      },
      act: (cubit) => cubit.createUser(
          name: testCreateUserParams.name,
          avatar: testCreateUserParams.avatar,
          createdAt: testCreateUserParams.createdAt),
      expect: () => const [CreatingUser(), UserCreated()],
      verify: (_) {
        verify(() => createUser(testCreateUserParams)).called(1);
        verifyNoMoreInteractions(createUser);
      },
    );

    blocTest<AuthCubit, AuthState>(
      'should emit [AuthError] when unsuccessfull.',
      build: () {
        when(() => createUser(any())).thenAnswer(
          (_) async => const Left(testApiFailure),
        );
        return cubit;
      },
      act: (cubit) => cubit.createUser(
          name: testCreateUserParams.name,
          avatar: testCreateUserParams.avatar,
          createdAt: testCreateUserParams.createdAt),
      expect: () =>
          [const CreatingUser(), AuthError(testApiFailure.errorMessage)],
      verify: (_) {
        verify(() => createUser(testCreateUserParams)).called(1);
        verifyNoMoreInteractions(createUser);
      },
    );
  });

  group('getUsers', () {
    const testUserList = [UserModel.empty()];

    blocTest<AuthCubit, AuthState>(
      'should emits [GettingUser, UserLoaded] when successfull.',
      build: () {
        when(() => getUsers()).thenAnswer(
          (_) async => const Right(testUserList),
        );
        return cubit;
      },
      act: (cubit) => cubit.getUsers(),
      expect: () => const [GettingUsers(), UserLoaded(testUserList)],
      verify: (_) {
        verify(() => getUsers()).called(1);
        verifyNoMoreInteractions(getUsers);
      },
    );

    blocTest<AuthCubit, AuthState>(
      'should emit [AuthError] when unsuccessfull.',
      build: () {
        when(() => getUsers()).thenAnswer(
          (_) async => const Left(testApiFailure),
        );
        return cubit;
      },
      act: (cubit) => cubit.getUsers(),
      expect: () =>
          [const GettingUsers(), AuthError(testApiFailure.errorMessage)],
      verify: (_) {
        verify(() => getUsers()).called(1);
        verifyNoMoreInteractions(getUsers);
      },
    );
  });
}
