import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_tutorial/core/errors/failure.dart';
import 'package:tdd_tutorial/src/auth/data/models/user_model.dart';
import 'package:tdd_tutorial/src/auth/domain/usecases/create_user.dart';
import 'package:tdd_tutorial/src/auth/domain/usecases/get_users.dart';
import 'package:tdd_tutorial/src/auth/presentation/bloc/auth_bloc.dart';

class MockGetUsers extends Mock implements GetUsers {}

class MockCreateUser extends Mock implements CreateUser {}

void main() {
  late GetUsers getUsers;
  late CreateUser createUser;
  late AuthBloc bloc;

  const testCreateUserParams = CreateUserParams.empty();
  const testApiFailure = ApiFailure(message: 'Bad Request', statusCode: 400);

  setUp(() {
    getUsers = MockGetUsers();
    createUser = MockCreateUser();
    bloc = AuthBloc(createUser: createUser, getUsers: getUsers);
    registerFallbackValue(testCreateUserParams);
  });

  tearDown(() => bloc.close());

  test('initial state should be [AuthInitial]', () async {
    // Assert
    expect(bloc.state, const AuthInitial());
  });

  group('createUser', () {
    blocTest<AuthBloc, AuthState>(
      'should emits [CreatingUser, UserCreated] when successfull.',
      build: () {
        when(() => createUser(any())).thenAnswer(
          (_) async => const Right(null),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(CreateUserEvent(
          name: testCreateUserParams.name,
          avatar: testCreateUserParams.avatar,
          createdAt: testCreateUserParams.createdAt)),
      expect: () => const [CreatingUser(), UserCreated()],
      verify: (_) {
        verify(() => createUser(testCreateUserParams)).called(1);
        verifyNoMoreInteractions(createUser);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [AuthError] when unsuccessfull.',
      build: () {
        when(() => createUser(any())).thenAnswer(
          (_) async => const Left(testApiFailure),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(CreateUserEvent(
          name: testCreateUserParams.name,
          avatar: testCreateUserParams.avatar,
          createdAt: testCreateUserParams.createdAt)),
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

    blocTest<AuthBloc, AuthState>(
      'should emits [GettingUser, UserLoaded] when successfull.',
      build: () {
        when(() => getUsers()).thenAnswer(
          (_) async => const Right(testUserList),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const GetUserEvent()),
      expect: () => const [GettingUsers(), UserLoaded(testUserList)],
      verify: (_) {
        verify(() => getUsers()).called(1);
        verifyNoMoreInteractions(getUsers);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [AuthError] when unsuccessfull.',
      build: () {
        when(() => getUsers()).thenAnswer(
          (_) async => const Left(testApiFailure),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const GetUserEvent()),
      expect: () =>
          [const GettingUsers(), AuthError(testApiFailure.errorMessage)],
      verify: (_) {
        verify(() => getUsers()).called(1);
        verifyNoMoreInteractions(getUsers);
      },
    );
  });
}
