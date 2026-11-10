import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_bird/router/app_router.dart';

import '../view_models/register_view_model.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  static final _usernameRegex = RegExp(r'^[a-zA-Z0-9_]{3,20}$');
  static final _emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _register() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final vm = context.read<RegisterViewModel>();

    vm
      ..setEmail(_emailController.text.trim())
      ..setPassword(_passwordController.text)
      ..setUsername(_usernameController.text.trim());

    if (!vm.register()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nazwa użytkownika lub e-mail są już zajęte'),
        ),
      );
      return;
    }

    appRouter.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Divider(),
                Text('Social Bird'),
                Text('Utworz konto'),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                  validator: (value) {
                    final username = value?.trim() ?? '';
                    if (username.isEmpty) {
                      return 'Podaj nazwę użytkownika';
                    }
                    if (!_usernameRegex.hasMatch(username)) {
                      return 'Użyj 3-20 liter, cyfr lub znaków _';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    final email = value?.trim() ?? '';
                    if (email.isEmpty) {
                      return 'Podaj adres e-mail';
                    }
                    if (!_emailRegex.hasMatch(email)) {
                      return 'Podaj prawidłowy adres e-mail';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: (value) {
                    if ((value ?? '').length < 6) {
                      return 'Hasło musi mieć co najmniej 6 znaków';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    alignLabelWithHint: true,
                  ),
                  validator: (value) {
                    if ((value ?? '').isEmpty) {
                      return 'Powtórz hasło';
                    }
                    if (value != _passwordController.text) {
                      return 'Hasła nie są takie same';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: _register,
                  child: const Text('Zarejestruj'),
                ),
                const Text('Masz już konto?'),
                ElevatedButton(
                  onPressed: () {
                    appRouter.push('/login');
                  },
                  child: const Text('Zaloguj'),
                ),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
