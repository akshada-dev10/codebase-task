import 'package:codebase_task/domain/entity/user_entities.dart';
import 'package:codebase_task/domain/repository/get_user_repository.dart';

class GetUsersUseCase {
  final UserRepository _repository;

  GetUsersUseCase(this._repository);

  Future<List<User>> execute(int page) async {
    return _repository.getUsers(page);
  }
}
