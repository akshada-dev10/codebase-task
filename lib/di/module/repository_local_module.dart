
import 'package:codebase_task/data/repository/user_local_repository.dart';
import 'package:codebase_task/data/source/local/user_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageDataSourceProvider = Provider<LocalStorageDataSource>(
      (ref) => LocalStorageDataSourceImpl(),
);
final userDataUseCaseProvider = Provider<UserDataUseCase>(
      (ref) => UserDataUseCase(ref.read(localStorageDataSourceProvider)),
);