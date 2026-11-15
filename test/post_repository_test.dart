import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:social_bird/db/app_database.dart';
import 'package:social_bird/models/post_model.dart';
import 'package:social_bird/repositories/post_repository.dart';

void main() {
  late AppDatabase database;
  late PostRepository repository;

  setUp(() {
    database = AppDatabase(executor: NativeDatabase.memory());
    repository = PostRepository(database);
  });

  tearDown(() => database.close());

  test('inserts trimmed posts and watches newest posts first', () async {
    final postsIterator = StreamIterator(repository.watchPosts());
    expect(await postsIterator.moveNext(), isTrue);
    expect(postsIterator.current, isEmpty);

    final firstPostFuture = postsIterator.moveNext();
    final firstPost = await repository.insertPost(
      content: '  First post  ',
      authorName: ' Example User ',
      authorHandle: ' @example ',
    );
    expect(await firstPostFuture, isTrue);
    expect(postsIterator.current.map((post) => post.id), [firstPost.id]);

    final secondPostFuture = postsIterator.moveNext();
    final secondPost = await repository.insertPost(
      content: 'Second post',
      authorName: 'Example User',
      authorHandle: '@example',
    );

    expect(firstPost.content, 'First post');
    expect(firstPost.authorName, 'Example User');
    expect(firstPost.authorHandle, '@example');
    expect(await secondPostFuture, isTrue);
    expect(postsIterator.current.map((post) => post.id), [
      secondPost.id,
      firstPost.id,
    ]);
    await postsIterator.cancel();
  });

  test('rejects empty posts and posts over the content limit', () async {
    await expectLater(
      repository.insertPost(
        content: '   ',
        authorName: 'Example User',
        authorHandle: '@example',
      ),
      throwsArgumentError,
    );
    await expectLater(
      repository.insertPost(
        content: 'x' * (PostModel.maxContentLength + 1),
        authorName: 'Example User',
        authorHandle: '@example',
      ),
      throwsArgumentError,
    );
  });

  test('deletes posts from SQLite and emits the updated list', () async {
    final post = await repository.insertPost(
      content: 'Post to delete',
      authorName: 'Example User',
      authorHandle: '@example',
    );
    final postsIterator = StreamIterator(repository.watchPosts());
    expect(await postsIterator.moveNext(), isTrue);
    expect(postsIterator.current.map((item) => item.id), [post.id]);

    final deletedPostsFuture = postsIterator.moveNext();
    expect(await repository.deletePost(post.id), isTrue);
    expect(await deletedPostsFuture, isTrue);
    expect(postsIterator.current, isEmpty);
    expect(await repository.deletePost(post.id), isFalse);
    await postsIterator.cancel();
  });
}
