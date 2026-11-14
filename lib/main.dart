import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_bird/db/app_database.dart';
import 'package:social_bird/services/post_service.dart';
import 'package:social_bird/services/user_service.dart';
import 'package:social_bird/view_models/welcome_view_model.dart';
import 'package:social_bird/router/app_router.dart';

import 'view_models/login_view_model.dart';
import 'view_models/post_view_model.dart';
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
      child: Builder(
        builder: (context) => Provider<UserService>(
          create: (_) => UserService(database: context.read<AppDatabase>()),
          child: Builder(
            builder: (context) => MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) => WelcomeViewModel()),
                ChangeNotifierProvider(
                  create: (_) => RegisterViewModel(
                    userService: context.read<UserService>(),
                  ),
                ),
                ChangeNotifierProvider(
                  create: (_) => LoginViewModel(
                    userService: context.read<UserService>(),
                  ),
                ),
                ChangeNotifierProvider(
                  create: (_) => PostViewModel(
                    postService: PostService(
                      database: context.read<AppDatabase>(),
                    ),
                    userService: context.read<UserService>(),
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
          ),
        ),
      ),
    );
  }
}
