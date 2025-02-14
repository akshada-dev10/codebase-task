import 'package:codebase_task/data/repository/user_repository_implementation.dart';
import 'package:codebase_task/di/module/repository_local_module.dart';
import 'package:codebase_task/domain/entity/user_entities.dart';
import 'package:codebase_task/domain/repository/get_user_repository.dart';
import 'package:codebase_task/domain/usecases/user_usecase.dart';
import 'package:codebase_task/presentation/provider/user_provider.dart';
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
  final localStorageDataSource = ref.watch(localStorageDataSourceProvider);
  return UserRepositoryImplementation(dio, localStorageDataSource);
});


final userProvider = Provider<UserViewModel>((ref) {
  final getUsersUseCase = ref.watch(getUsersUseCaseProvider);
  final userDataUseCase = ref.watch(userDataUseCaseProvider);
  return UserViewModel(getUsersUseCase, userDataUseCase);
});

final userStreamProvider = StreamProvider<List<User>>((ref) {
  final userNotifier = ref.watch(userProvider);
  return Stream<List<User>>.periodic(
    const Duration(seconds: 5),
        (_) => userNotifier.users,
  ).asBroadcastStream();
});


