import 'package:codebase_task/data/local_db.dart';
import 'package:codebase_task/di/user_usecase.dart';
import 'package:codebase_task/domain/models/user_model.dart';
import 'package:codebase_task/domain/repository/get_user_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserNotifier extends ChangeNotifier {
  final UserRepository userRepository;
  List<User> users = [];
  int _page = 1;
  bool isFetchingMore = false;
  bool hasMoreData = true;

  UserNotifier(this.userRepository);

  Future<void> fetchUsers({bool reset = false}) async {
    if (reset) {
      _page = 1;
      users.clear();
      hasMoreData = true;
    }

    if (!reset) {
      users = await LocalStorage.getCachedUsers();
      notifyListeners();
    }

    final newUsers = await userRepository.getUsers(_page);
    users = newUsers;

    await LocalStorage.cacheUsers(users);

    hasMoreData = newUsers.isNotEmpty;
    notifyListeners();
  }

  Future<void> loadMore() async {
    if (isFetchingMore || !hasMoreData) return;

    isFetchingMore = true;
    _page++;

    try {
      final newUsers = await userRepository.getUsers(_page);
      if (newUsers.isEmpty) {
        hasMoreData = false;
      } else {
        users.addAll(newUsers);
      }
      await LocalStorage.cacheUsers(users);
      notifyListeners();
    } finally {
      isFetchingMore = false;
    }
  }
}

final userProvider = ChangeNotifierProvider(
      (ref) => UserNotifier(ref.read(userRepositoryProvider)),
);
