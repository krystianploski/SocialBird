import 'dart:convert';
import 'dart:math';

import 'package:cryptography/cryptography.dart';

import '../db/app_database.dart';
import '../models/user_model.dart';

class UserService {
  factory UserService({required AppDatabase database}) {
    return UserService._(database);
  }

  UserService._(this._database);

  static final _passwordHasher = Pbkdf2(
    macAlgorithm: Hmac.sha256(),
    iterations: 120000,
    bits: 256,
  );
  static final _secureRandom = Random.secure();

  final AppDatabase _database;
  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;

  Future<UserModel?> login(String email, String password) async {
    final normalizedEmail = email.trim().toLowerCase();
    final storedUser = await _database.getUserByEmail(normalizedEmail);
    if (storedUser == null ||
        !await _passwordMatches(
          password,
          storedUser.passwordSalt,
          storedUser.passwordHash,
        )) {
      _currentUser = null;
      return null;
    }

    return _setCurrentUser(
      UserModel(
        username: storedUser.username,
        email: storedUser.email,
        password: '',
      ),
    );
  }

  void logout() {
    _currentUser = null;
  }

  Future<bool> register(UserModel user) async {
    final normalizedEmail = user.email.trim().toLowerCase();
    final normalizedUsername = user.username.trim().toLowerCase();
    final exists = await _database.userExists(
      normalizedEmail: normalizedEmail,
      normalizedUsername: normalizedUsername,
    );
    if (exists) {
      return false;
    }

    final salt = List<int>.generate(
      16,
      (_) => _secureRandom.nextInt(256),
      growable: false,
    );
    final passwordHash = await _hashPassword(user.password, salt);
    await _database.insertUser(
      UsersCompanion.insert(
        username: user.username.trim(),
        normalizedUsername: normalizedUsername,
        email: user.email.trim(),
        normalizedEmail: normalizedEmail,
        passwordHash: base64UrlEncode(passwordHash),
        passwordSalt: base64UrlEncode(salt),
      ),
    );

    _setCurrentUser(
      UserModel(
        username: user.username.trim(),
        email: user.email.trim(),
        password: '',
      ),
    );
    return true;
  }

  UserModel _setCurrentUser(UserModel user) {
    _currentUser = user;
    return user;
  }

  Future<List<int>> _hashPassword(String password, List<int> salt) async {
    final key = await _passwordHasher.deriveKey(
      secretKey: SecretKey(utf8.encode(password)),
      nonce: salt,
    );
    return key.extractBytes();
  }

  Future<bool> _passwordMatches(
    String password,
    String encodedSalt,
    String encodedHash,
  ) async {
    final salt = base64Url.decode(encodedSalt);
    final expectedHash = base64Url.decode(encodedHash);
    final actualHash = await _hashPassword(password, salt);
    if (actualHash.length != expectedHash.length) {
      return false;
    }

    var difference = 0;
    for (var index = 0; index < actualHash.length; index++) {
      difference |= actualHash[index] ^ expectedHash[index];
    }
    return difference == 0;
  }
}
