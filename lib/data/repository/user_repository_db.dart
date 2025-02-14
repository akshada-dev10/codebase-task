import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:codebase_task/domain/entity/user_entities.dart';

abstract class LocalStorageDataSource {
  Future<void> cacheUsers(List<User> users);
  Future<List<User>> getCachedUsers();
  Future<void> clearCache();
}

class LocalStorageDataSourceImpl implements LocalStorageDataSource {
  static const String _usersKey = "cached_users";

  @override
  Future<void> cacheUsers(List<User> users) async {
    final prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(users.map((user) => user.toJson()).toList());
    await prefs.setString(_usersKey, jsonString);
  }

  @override
  Future<List<User>> getCachedUsers() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(_usersKey);

    if (jsonString == null) {
      return [];
    }

    List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((user) => User.fromJson(user)).toList();
  }

  @override
  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_usersKey);
  }
}




