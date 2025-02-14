import 'package:codebase_task/domain/entity/user_entities.dart';

abstract class UserRepository {
  Future<List<User>> getUsers(int page);
}
