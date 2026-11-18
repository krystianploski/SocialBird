import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_bird/db/app_database.dart';
import 'package:social_bird/services/post_api_service.dart';
import 'package:social_bird/repositories/post_repository.dart';
import 'package:social_bird/repositories/quote_repository.dart';
import 'package:social_bird/services/quote_api_service.dart';
import 'package:social_bird/services/user_service.dart';
import 'package:social_bird/router/app_router.dart';
import 'package:social_bird/view_models/welcome_view_model.dart';

import 'view_models/login_view_model.dart';
import 'view_models/post_view_model.dart';
import 'view_models/quote_view_model.dart';
import 'view_models/register_view_model.dart';

void main() {
  runApp(const SocialBirdApp());
}

/// Root Widget
class SocialBirdApp extends StatelessWidget {
  const SocialBirdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<AppDatabase>(
      create: (_) => AppDatabase(),
      dispose: (_, database) => database.close(),
      child: MultiProvider(
        providers: [
          Provider<PostApiService>(
            create: (_) => PostApiService(),
            dispose: (_, service) => service.close(),
          ),
          Provider<QuoteApiService>(
            create: (_) => QuoteApiService(),
            dispose: (_, service) => service.close(),
          ),
          Provider<UserService>(
            create: (context) =>
                UserService(database: context.read<AppDatabase>()),
          ),
          ChangeNotifierProvider(
            create: (context) => WelcomeViewModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => RegisterViewModel(
              userService: context.read<UserService>(),
            ),
          ),
          ChangeNotifierProvider(
            create: (context) => LoginViewModel(
              userService: context.read<UserService>(),
            ),
          ),
          ChangeNotifierProvider(
            create: (context) => PostViewModel(
              postRepository: PostRepository(
                context.read<AppDatabase>(),
                context.read<PostApiService>(),
              ),
              userService: context.read<UserService>(),
            ),
          ),
          ChangeNotifierProvider(
            create: (context) => QuoteViewModel(
              quoteRepository: QuoteRepository(
                context.read<QuoteApiService>(),
              ),
            ),
          ),
        ],
        child: MaterialApp.router(
          routerConfig: appRouter,
          title: 'Social Bird',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.dark,
            ),
            useMaterial3: true,
          ),
        ),
      ),
    );
  }
}
