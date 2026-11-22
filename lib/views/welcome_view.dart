import 'package:flutter/material.dart';
import 'package:social_bird/router/app_router.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                appRouter.push('/login');
              },
              child: Text('Zaloguj'),
            ),
            OutlinedButton(
              onPressed: () {
                appRouter.push('/register');
              },
              child: Text('Zarejestruj'),
            ),

          ],
        ),
      ),
    );
  }
}
