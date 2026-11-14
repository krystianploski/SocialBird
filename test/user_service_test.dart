import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:social_bird/db/app_database.dart';
import 'package:social_bird/models/user_model.dart';
import 'package:social_bird/services/user_service.dart';

void main() {
  late Directory directory;
  late AppDatabase database;
  late UserService service;

  setUp(() async {
    directory = await Directory.systemTemp.createTemp('social_bird_users_');
    database = AppDatabase(
      executor: NativeDatabase(File('${directory.path}\\users.sqlite')),
    );
    service = UserService(database: database);
  });

  tearDown(() async {
    await database.close();
    await directory.delete(recursive: true);
  });

  test('accounts can log in again after reopening the database', () async {
    const user = UserModel(
      username: 'TestUser',
      email: 'login-flow-test@example.com',
      password: 'test-password',
    );

    expect(await service.register(user), isTrue);
    expect(service.currentUser?.username, user.username);
    await database.insertPost(
      PostsCompanion.insert(
        id: 'shared-post',
        authorName: 'Post author',
        authorHandle: '@postauthor',
        content: 'Shared post',
        createdAt: DateTime(2026),
      ),
    );
    await database.close();

    database = AppDatabase(
      executor: NativeDatabase(File('${directory.path}\\users.sqlite')),
    );
    final loginService = UserService(database: database);
    final loggedInUser = await loginService.login(user.email, user.password);

    expect(loggedInUser?.username, user.username);
    expect(loggedInUser?.email, user.email);
    expect(loggedInUser?.password, isEmpty);
    expect(loginService.currentUser, same(loggedInUser));
    expect(
      (await database.watchPosts().first).map((post) => post.content),
      ['Shared post'],
    );
  });

  test('email matching is case-insensitive', () async {
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

    expect(await service.register(user), isTrue);
    final loggedInUser = await service.login(
      'CASE-INSENSITIVE-TEST@EXAMPLE.COM',
      user.password,
    );
    expect(loggedInUser?.username, user.username);
    expect(await service.register(duplicate), isFalse);
  });

  test('register and login update the current user session', () async {
    const user = UserModel(
      username: 'session-user-test',
      email: 'session-user-test@example.com',
      password: 'test-password',
    );

    expect(await service.register(user), isTrue);
    expect(service.currentUser?.username, user.username);

    service.logout();
    expect(service.currentUser, isNull);

    final loggedInUser = await service.login(user.email, user.password);
    expect(loggedInUser?.username, user.username);
    expect(service.currentUser, same(loggedInUser));

    service.logout();
    expect(await service.login(user.email, 'wrong-password'), isNull);
    expect(service.currentUser, isNull);
  });

  test('usernames are unique regardless of capitalization', () async {
    const first = UserModel(
      username: 'UniqueHandleTest',
      email: 'unique-handle-first@example.com',
      password: 'test-password',
    );
    const duplicate = UserModel(
      username: 'uniquehandletest',
      email: 'unique-handle-second@example.com',
      password: 'test-password',
    );

    expect(await service.register(first), isTrue);
    expect(await service.register(duplicate), isFalse);
  });
}
