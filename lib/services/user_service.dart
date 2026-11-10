import '../models/user_model.dart';

class UserService {
  static final UserService _instance = UserService._internal();

  factory UserService() => _instance;

  UserService._internal();

  final List<UserModel> _users = [];
  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;

  UserModel? login(String email, String password) {
    final normalizedEmail = email.trim().toLowerCase();
    for (final user in _users) {
      if (user.email.trim().toLowerCase() == normalizedEmail &&
          user.password == password) {
        _currentUser = user;
        return user;
      }
    }
    _currentUser = null;
    return null;
  }

  void logout() {
    _currentUser = null;
  }

  bool register(UserModel user) {
    final normalizedEmail = user.email.trim().toLowerCase();
    final normalizedUsername = user.username.trim().toLowerCase();
    final exists = _users.any((existingUser) {
      return existingUser.email.trim().toLowerCase() == normalizedEmail ||
          existingUser.username.trim().toLowerCase() == normalizedUsername;
    });

    if (exists) {
      return false;
    }

    _users.add(user);
    _currentUser = user;

    return true;
  }
}
