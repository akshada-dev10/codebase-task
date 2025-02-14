import 'package:codebase_task/data/source/local/user_data_usecase.dart';
import 'package:codebase_task/domain/entity/user_entities.dart';
import 'package:codebase_task/domain/repository/get_user_repository.dart';
import 'package:flutter/foundation.dart';

class UserNotifier extends ChangeNotifier {
  final UserRepository userRepository;
  final UserDataUseCase userDataUseCase;
  List<User> users = [];
  int _page = 1;
  bool isFetchingMore = false;
  bool hasMoreData = true;

  UserNotifier(this.userRepository,this.userDataUseCase);

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

    final newUsers = await userRepository.getUsers(_page);

    final uniqueUsers = newUsers.where((user) => !users.any((existing) => existing.id == user.id)).toList();

    if (reset) {
      users = uniqueUsers;
    } else {
      users.addAll(uniqueUsers);
    }

    await userDataUseCase.saveUsers(users);

    hasMoreData = uniqueUsers.isNotEmpty;
    notifyListeners();
  }

  Future<void> loadMore() async {
    if (isFetchingMore || !hasMoreData) return;

    isFetchingMore = true;
    _page++;

    try {
      final newUsers = await userRepository.getUsers(_page);

      final uniqueUsers = newUsers.where((user) => !users.any((existing) => existing.id == user.id)).toList();

      if (uniqueUsers.isEmpty) {
        hasMoreData = false;
      } else {
        users.addAll(uniqueUsers);
        await userDataUseCase.saveUsers(users);
      }

      notifyListeners();
    } finally {
      isFetchingMore = false;
    }
  }
}



