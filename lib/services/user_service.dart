//json, validation, login to feed
//creating user, reading user, updating user, deleting user

import '../models/user_model.dart';

class UserService {
  static final UserService _instance = UserService._internal();

  factory UserService() => _instance;

  UserService._internal();

  final List<UserModel> _users = [];

  UserModel? login(String email, String password) {
    final normalizedEmail = email.trim().toLowerCase();
    for (final user in _users) {
      if (user.email.trim().toLowerCase() == normalizedEmail &&
          user.password == password) {
        return user;
      }
    }
    return null;
  }

  bool register(UserModel user) {
    final normalizedEmail = user.email.trim().toLowerCase();
    final exists = _users.any(
      (existingUser) =>
          existingUser.email.trim().toLowerCase() == normalizedEmail,
    );

    if (exists) {
      return false;
    }

    _users.add(user);

    return true;
  }
}
