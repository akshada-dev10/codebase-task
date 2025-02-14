import 'package:codebase_task/data/repository/user_repository_db.dart';
import 'package:codebase_task/domain/entity/user_entities.dart';

class UserDataUseCase {
  final LocalStorageDataSource localStorageDataSource;

  UserDataUseCase(this.localStorageDataSource);

  Future<void> saveUsers(List<User> users) async {
    await localStorageDataSource.cacheUsers(users);
  }

  Future<List<User>> getUsers() async {
    return await localStorageDataSource.getCachedUsers();
  }

  Future<void> clearUsers() async {
    await localStorageDataSource.clearCache();
  }
}
