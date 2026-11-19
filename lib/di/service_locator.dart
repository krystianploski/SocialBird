import 'package:get_it/get_it.dart';

import '../db/app_database.dart';
import '../repositories/post_repository.dart';
import '../repositories/quote_repository.dart';
import '../services/post_api_service.dart';
import '../services/quote_api_service.dart';
import '../services/user_service.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt.registerLazySingleton<AppDatabase>(
    AppDatabase.new,
    dispose: (database) => database.close(),
  );
  getIt.registerLazySingleton<PostApiService>(
    PostApiService.new,
    dispose: (service) => service.close(),
  );
  getIt.registerLazySingleton<QuoteApiService>(
    QuoteApiService.new,
    dispose: (service) => service.close(),
  );
  getIt.registerLazySingleton<UserService>(
    () => UserService(database: getIt<AppDatabase>()),
  );
  getIt.registerLazySingleton<PostRepository>(
    () => PostRepository(getIt<AppDatabase>(), getIt<PostApiService>()),
  );
  getIt.registerLazySingleton<QuoteRepository>(
    () => QuoteRepository(getIt<QuoteApiService>()),
  );
}
