import 'package:codebase_task/data/repository/user_repository_db.dart';
import 'package:codebase_task/domain/entity/user_entities.dart';
import 'package:codebase_task/domain/repository/get_user_repository.dart';
import 'package:dio/dio.dart';

class UserRepositoryImplementation implements UserRepository {
  final Dio _dio;
  final LocalStorageDataSource localStorageDataSource;

  UserRepositoryImplementation(this._dio, this.localStorageDataSource);

  /// Call to get users from API
  @override
  Future<List<User>> getUsers(int page) async {
    try {
      final response = await _dio.get(
        'https://reqres.in/api/users',
        queryParameters: {'per_page': 10, 'page': page},
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] as List<dynamic>;
        final users = data.map((json) => User.fromJson(json)).toList();

        if (page == 1) {
          await localStorageDataSource.cacheUsers(users);
        }

        return users;
      } else {
        throw Exception('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }
}
