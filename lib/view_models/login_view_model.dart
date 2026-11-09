import 'package:flutter/material.dart';

import '../services/user_service.dart';

class LoginViewModel extends ChangeNotifier {
  final userService = UserService();

  String _email = '';
  String _password = '';

  String get email => _email;
  String get password => _password;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  Future<bool> login() async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 2));

      final user = userService.login(email, password);
      return user != null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
