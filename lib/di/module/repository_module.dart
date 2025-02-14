
import 'package:codebase_task/data/repository/user_local_repository.dart';
import 'package:codebase_task/data/repository/user_repository_implementation.dart';
import 'package:codebase_task/data/source/local/user_data_usecase.dart';
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

final userProvider = ChangeNotifierProvider(
      (ref) => UserNotifier(
    ref.read(userRepositoryProvider),
    ref.read(userDataUseCaseProvider),
  ),
);


final localStorageDataSourceProvider = Provider<LocalStorageDataSource>(
      (ref) => LocalStorageDataSourceImpl(),
);
final userDataUseCaseProvider = Provider<UserDataUseCase>(
      (ref) => UserDataUseCase(ref.read(localStorageDataSourceProvider)),
);

