import 'package:flutter_test/flutter_test.dart';
import 'package:social_bird/models/user_model.dart';
import 'package:social_bird/services/user_service.dart';

void main() {
  test('a registered user can log in through another service instance', () {
    final registrationService = UserService();
    final loginService = UserService();
    const user = UserModel(
      username: 'Test User',
      email: 'login-flow-test@example.com',
      password: 'test-password',
    );

    expect(identical(registrationService, loginService), isTrue);
    expect(registrationService.register(user), isTrue);
    expect(loginService.login(user.email, user.password), same(user));
  });

  test('email matching is case-insensitive', () {
    final service = UserService();
    const user = UserModel(
      username: 'CaseSensitive',
      email: 'case-insensitive-test@example.com',
      password: 'test-password',
    );
    const duplicate = UserModel(
      username: 'Duplicate',
      email: 'CASE-INSENSITIVE-TEST@EXAMPLE.COM',
      password: 'another-password',
    );

    expect(service.register(user), isTrue);
    expect(
      service.login('CASE-INSENSITIVE-TEST@EXAMPLE.COM', user.password),
      same(user),
    );
    expect(service.register(duplicate), isFalse);
  });
}
