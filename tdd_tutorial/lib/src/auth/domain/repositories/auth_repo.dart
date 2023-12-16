import 'package:tdd_tutorial/core/utils/typedef.dart';
import 'package:tdd_tutorial/src/auth/domain/entities/user.dart';

abstract class AuthRepository {
  const AuthRepository();

  ResultVoid createUser(
      {required String createdAt,
      required String name,
      required String avatar});

  ResultFuture<List<User>> getUsers();
}
