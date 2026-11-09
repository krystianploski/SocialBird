import "package:flutter/material.dart";
import "package:social_bird/router/app_router.dart";
import "package:social_bird/view_models/login_view_model.dart";
import "package:provider/provider.dart";

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  static final _emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final vm = context.read<LoginViewModel>();
    vm
      ..setEmail(_emailController.text.trim())
      ..setPassword(_passwordController.text);

    final success = await vm.login();

    // Check if the widget is still mounted (true == still in the widget tree) before showing a SnackBar or navigating
    if (!mounted) {
      return;
    }

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nieprawidłowy e-mail lub hasło')),
      );
      return;
    }

    appRouter.go('/home');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                Consumer<LoginViewModel>(
                  builder: (context, viewModel, child) {
                    return ElevatedButton(
                      onPressed: viewModel.isLoading ? null : _login,
                      child: viewModel.isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : child!,
                    );
                  },
                  child: const Text('Zaloguj'),
                ),
                const Text('Nie masz konta?'),
                OutlinedButton(
                  onPressed: () {
                    appRouter.push('/register');
                  },
                  child: const Text('Zarejestruj'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
