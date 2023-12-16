import 'package:tdd_tutorial/core/usecases/usecase.dart';
import 'package:tdd_tutorial/core/utils/typedef.dart';
import 'package:tdd_tutorial/src/auth/domain/entities/user.dart';
import 'package:tdd_tutorial/src/auth/domain/repositories/auth_repo.dart';

class GetUsers extends UsecaseWithoutParams<List<User>> {
  const GetUsers(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<List<User>> call() async => _repository.getUsers();
}
