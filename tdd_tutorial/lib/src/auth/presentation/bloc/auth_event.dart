part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class CreateUserEvent extends AuthEvent {
  const CreateUserEvent(
      {required this.name, required this.avatar, required this.createdAt});

  final String name;
  final String avatar;
  final String createdAt;

  @override
  List<Object> get props => [name, avatar, createdAt];
}

class GetUserEvent extends AuthEvent {
  const GetUserEvent();
}
