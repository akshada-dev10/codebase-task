import 'package:codebase_task/domain/models/user_model.dart';
import 'package:dio/dio.dart';

class UserRepository {
  final Dio _dio;

  UserRepository(this._dio);

  Future<List<User>> getUsers(int page) async {
    try {
      final response = await _dio.get(
        'https://reqres.in/api/users',
        queryParameters: {'per_page': 10, 'page': page},
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] as List<dynamic>;
        return data.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }
}
