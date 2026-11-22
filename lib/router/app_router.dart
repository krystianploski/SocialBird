import 'package:go_router/go_router.dart';

import '../views/welcome_view.dart';
import '../views/login_view.dart';
import '../views/register_view.dart';
import '../views/home_view.dart';
import '../views/profile_view.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const WelcomeView()),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterView(),
    ),
    GoRoute(path: '/login', builder: (context, state) => const LoginView()),
    GoRoute(path: '/home', builder: (context, state) => const HomeView()),
    GoRoute(path: '/profile', builder: (context, state) => const ProfileView()),
  ],
);
