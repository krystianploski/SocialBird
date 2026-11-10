import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:social_bird/models/user_model.dart';
import 'package:social_bird/services/user_service.dart';

import 'package:social_bird/view_models/login_view_model.dart';
import 'package:social_bird/view_models/post_view_model.dart';
import 'package:social_bird/view_models/register_view_model.dart';
import 'package:social_bird/views/home_view.dart';
import 'package:social_bird/views/login_view.dart';
import 'package:social_bird/views/register_view.dart';
import 'package:social_bird/views/welcome_view.dart';

Widget _testApp(Widget child) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LoginViewModel()),
      ChangeNotifierProvider(create: (_) => RegisterViewModel()),
      ChangeNotifierProvider(create: (_) => PostViewModel()),
    ],
    child: MaterialApp(home: child),
  );
}

void main() {
  testWidgets('Login view displays login and registration actions', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: WelcomeView()));

    expect(find.text('Zaloguj'), findsOneWidget);
    expect(find.text('Zarejestruj'), findsOneWidget);
  });

  testWidgets('login shows field errors for invalid email and password', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_testApp(const LoginView()));

    await tester.tap(find.text('Zaloguj'));
    await tester.pump();

    expect(find.text('Podaj adres e-mail'), findsOneWidget);
    expect(find.text('Hasło musi mieć co najmniej 6 znaków'), findsOneWidget);
    expect(find.text('Nieprawidłowy e-mail lub hasło'), findsNothing);

    await tester.enterText(find.byType(TextFormField).at(0), 'not-an-email');
    await tester.enterText(find.byType(TextFormField).at(1), '12345');
    await tester.tap(find.text('Zaloguj'));
    await tester.pump();

    expect(find.text('Podaj prawidłowy adres e-mail'), findsOneWidget);
    expect(find.text('Nieprawidłowy e-mail lub hasło'), findsNothing);

    await tester.enterText(
      find.byType(TextFormField).at(0),
      'unknown@example.com',
    );
    await tester.enterText(find.byType(TextFormField).at(1), 'valid-pass');
    await tester.tap(find.text('Zaloguj'));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(
      tester.widget<ElevatedButton>(find.byType(ElevatedButton)).onPressed,
      isNull,
    );

    await tester.pump(const Duration(seconds: 2));
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('Nieprawidłowy e-mail lub hasło'), findsOneWidget);
  });

  testWidgets(
    'login shows authentication error for valid-looking credentials',
    (WidgetTester tester) async {
      await tester.pumpWidget(_testApp(const LoginView()));

      await tester.enterText(
        find.byType(TextFormField).at(0),
        'unknown@example.com',
      );
      await tester.enterText(find.byType(TextFormField).at(1), 'valid-pass');
      await tester.tap(find.text('Zaloguj'));
      await tester.pump();
      await tester.pump(const Duration(seconds: 2));
      await tester.pump();

      expect(find.text('Podaj prawidłowy adres e-mail'), findsNothing);
      expect(find.text('Hasło musi mieć co najmniej 6 znaków'), findsNothing);
      expect(find.text('Nieprawidłowy e-mail lub hasło'), findsOneWidget);
    },
  );

  testWidgets('registration form validates required fields', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_testApp(const RegisterView()));

    await tester.tap(find.text('Zarejestruj'));
    await tester.pump();

    expect(find.text('Podaj nazwę użytkownika'), findsOneWidget);
    expect(find.text('Podaj adres e-mail'), findsOneWidget);
    expect(find.text('Hasło musi mieć co najmniej 6 znaków'), findsOneWidget);
    expect(find.text('Powtórz hasło'), findsOneWidget);
  });

  testWidgets('registration form validates username, email and password', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(400, 350);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(_testApp(const RegisterView()));

    await tester.enterText(find.byType(TextFormField).at(0), 'ab!');
    await tester.enterText(find.byType(TextFormField).at(1), 'invalid-email');
    await tester.enterText(find.byType(TextFormField).at(2), '12345');
    await tester.enterText(find.byType(TextFormField).at(3), 'different');
    await tester.tap(find.text('Zarejestruj'));
    await tester.pump();

    expect(find.text('Użyj 3-20 liter, cyfr lub znaków _'), findsOneWidget);
    expect(find.text('Podaj prawidłowy adres e-mail'), findsOneWidget);
    expect(find.text('Hasło musi mieć co najmniej 6 znaków'), findsOneWidget);
    expect(find.text('Hasła nie są takie same'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('registration reports an email that is already in use', (
    WidgetTester tester,
  ) async {
    final userService = UserService();
    const existingUser = UserModel(
      username: 'ExistingUser',
      email: 'existing-registration-test@example.com',
      password: 'existing-password',
    );
    expect(userService.register(existingUser), isTrue);
    userService.logout();

    await tester.pumpWidget(_testApp(const RegisterView()));
    await tester.enterText(find.byType(TextFormField).at(0), 'NewUser123');
    await tester.enterText(
      find.byType(TextFormField).at(1),
      existingUser.email.toUpperCase(),
    );
    await tester.enterText(find.byType(TextFormField).at(2), 'new-password');
    await tester.enterText(find.byType(TextFormField).at(3), 'new-password');
    await tester.tap(find.text('Zarejestruj'));
    await tester.pump();

    expect(
      find.text('Nazwa użytkownika lub e-mail są już zajęte'),
      findsOneWidget,
    );
  });

  testWidgets('home validates and displays a newly published post', (
    WidgetTester tester,
  ) async {
    final userService = UserService();
    const user = UserModel(
      username: 'PostAuthorTest',
      email: 'post-author-test@example.com',
      password: 'test-password',
    );
    expect(userService.register(user), isTrue);

    await tester.pumpWidget(_testApp(const HomeView()));

    await tester.tap(find.text('Opublikuj'));
    await tester.pump();
    expect(find.text('Treść posta nie może być pusta'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), '  Mój pierwszy post  ');
    await tester.tap(find.text('Opublikuj'));
    await tester.pump();

    expect(find.text('Mój pierwszy post'), findsOneWidget);
    expect(find.text(user.username), findsOneWidget);
    expect(
      find.textContaining('@${user.username.toLowerCase()}'),
      findsOneWidget,
    );
    expect(find.text('Nie ma jeszcze postów. Dodaj pierwszy!'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('home refuses to publish a post without an active user', (
    WidgetTester tester,
  ) async {
    UserService().logout();
    await tester.pumpWidget(_testApp(const HomeView()));
    await tester.enterText(find.byType(TextFormField), 'Post bez sesji');
    await tester.tap(find.text('Opublikuj'));
    await tester.pump();

    expect(find.text('Zaloguj się, aby opublikować post'), findsOneWidget);
    expect(find.text('Nie ma jeszcze postów. Dodaj pierwszy!'), findsOneWidget);
  });
}
