
import 'package:codebase_task/domain/repository/get_user_repository.dart';
import 'package:codebase_task/domain/usecase.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final getUsersUseCaseProvider = Provider<GetUsersUseCase>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return GetUsersUseCase(repository);
});

final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(
    baseUrl: 'https://reqres.in/api/',
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 10),
  ));
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return UserRepository(dio);
});