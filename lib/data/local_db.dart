import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:codebase_task/domain/models/user_model.dart';

class LocalStorage {
  static const String _usersKey = "cached_users";

  /// Save list of users to SharedPreferences
  static Future<void> cacheUsers(List<User> users) async {
    final prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(users.map((user) => user.toJson()).toList());
    await prefs.setString(_usersKey, jsonString);
  }

  /// Get list of users from SharedPreferences
  static Future<List<User>> getCachedUsers() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(_usersKey);

    if (jsonString == null) {
      return [];
    }

    List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((user) => User.fromJson(user)).toList();
  }

  /// Clear cached users
  static Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_usersKey);
  }
}
