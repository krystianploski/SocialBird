import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_bird/repositories/post_repository.dart';
import 'package:social_bird/repositories/quote_repository.dart';
import 'package:social_bird/router/app_router.dart';
import 'package:social_bird/services/user_service.dart';
import 'package:social_bird/view_models/welcome_view_model.dart';

import 'di/service_locator.dart';
import 'view_models/login_view_model.dart';
import 'view_models/post_view_model.dart';
import 'view_models/quote_view_model.dart';
import 'view_models/register_view_model.dart';
import 'view_models/theme_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(const SocialBirdApp());
}

class SocialBirdApp extends StatelessWidget {
  const SocialBirdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WelcomeViewModel()),
        ChangeNotifierProvider(create: (_) => ThemeViewModel()),
        ChangeNotifierProvider(
          create: (_) => RegisterViewModel(userService: getIt<UserService>()),
        ),
        ChangeNotifierProvider(
          create: (_) => LoginViewModel(userService: getIt<UserService>()),
        ),
        ChangeNotifierProvider(
          create: (_) => PostViewModel(
            postRepository: getIt<PostRepository>(),
            userService: getIt<UserService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              QuoteViewModel(quoteRepository: getIt<QuoteRepository>()),
        ),
      ],
      child: Consumer<ThemeViewModel>(
        builder: (context, themeViewModel, child) {
          return MaterialApp.router(
            routerConfig: appRouter,
            title: 'Social Bird',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness: Brightness.light,
              ),
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness: Brightness.dark,
              ),
              useMaterial3: true,
            ),
            themeMode: themeViewModel.isDarkMode
                ? ThemeMode.dark
                : ThemeMode.light,
          );
        },
      ),
    );
  }
}
