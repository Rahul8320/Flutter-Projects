import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_tutorial/src/auth/domain/entities/user.dart';
import 'package:tdd_tutorial/src/auth/domain/usecases/create_user.dart';
import 'package:tdd_tutorial/src/auth/domain/usecases/get_users.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required CreateUser createUser,
    required GetUsers getUsers,
  })  : _createUser = createUser,
        _getUsers = getUsers,
        super(const AuthInitial());

  final CreateUser _createUser;
  final GetUsers _getUsers;

  Future<void> createUser(
      {required String name,
      required String avatar,
      required String createdAt}) async {
    emit(const CreatingUser());

    final result = await _createUser(
        CreateUserParams(createdAt: createdAt, name: name, avatar: avatar));

    result.fold((failure) => emit(AuthError(failure.errorMessage)),
        (_) => emit(const UserCreated()));
  }

  Future<void> getUsers() async {
    emit(const GettingUsers());

    final result = await _getUsers();

    result.fold((failure) => emit(AuthError(failure.errorMessage)),
        (users) => emit(UserLoaded(users)));
  }
}
