import 'package:flutter_test/flutter_test.dart';
import 'package:social_bird/db/app_database.dart';
import 'package:social_bird/di/service_locator.dart';
import 'package:social_bird/repositories/post_repository.dart';
import 'package:social_bird/repositories/quote_repository.dart';
import 'package:social_bird/services/post_api_service.dart';
import 'package:social_bird/services/quote_api_service.dart';
import 'package:social_bird/services/user_service.dart';

void main() {
  setUp(() async {
    await getIt.reset();
    await setupDependencies();
  });

  tearDown(() => getIt.reset());

  test('registers app dependencies as singletons', () {
    expect(getIt<AppDatabase>(), same(getIt<AppDatabase>()));
    expect(getIt<UserService>(), same(getIt<UserService>()));
    expect(getIt<PostRepository>(), same(getIt<PostRepository>()));
    expect(getIt<QuoteRepository>(), same(getIt<QuoteRepository>()));
    expect(getIt<PostApiService>(), same(getIt<PostApiService>()));
    expect(getIt<QuoteApiService>(), same(getIt<QuoteApiService>()));
  });
}
