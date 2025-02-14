import 'dart:async';
import 'package:codebase_task/data/source/local/user_data_source.dart';
import 'package:codebase_task/domain/entity/user_entities.dart';
import 'package:codebase_task/domain/usecases/user_usecase.dart';


class UserViewModel {
  final GetUsersUseCase getUsersUseCase;
  final UserDataUseCase userDataUseCase;
  List<User> users = [];
  int _page = 1;
  bool isFetchingMore = false;
  bool hasMoreData = true;
  final StreamController<List<User>> _userStreamController = StreamController.broadcast();

  Stream<List<User>> get userStream => _userStreamController.stream;

  UserViewModel(this.getUsersUseCase, this.userDataUseCase) {
    fetchUsers();
  }

  Future<void> fetchUsers({bool reset = false}) async {
    if (reset) {
      _page = 1;
      users.clear();
      await userDataUseCase.clearUsers();
      hasMoreData = true;
    }

    if (users.isEmpty) {
      users = await userDataUseCase.getUsers();
    }

    final newUsers = await getUsersUseCase.execute(_page);
    final uniqueUsers = newUsers.where((user) => !users.any((existing) => existing.id == user.id)).toList();

    if (reset) {
      users = uniqueUsers;
    } else {
      users.addAll(uniqueUsers);
    }

    await userDataUseCase.saveUsers(users);
    hasMoreData = uniqueUsers.isNotEmpty;
    _userStreamController.add(users);
  }

  Future<void> loadMore() async {
    if (isFetchingMore || !hasMoreData) return;

    isFetchingMore = true;
    _page++;

    try {
      final newUsers = await getUsersUseCase.execute(_page);
      final uniqueUsers = newUsers.where((user) => !users.any((existing) => existing.id == user.id)).toList();

      if (uniqueUsers.isEmpty) {
        hasMoreData = false;
      } else {
        users.addAll(uniqueUsers);
        await userDataUseCase.saveUsers(users);
        _userStreamController.add(users);
      }
    } finally {
      isFetchingMore = false;
    }
  }

  void dispose() {
    _userStreamController.close();
  }
}
