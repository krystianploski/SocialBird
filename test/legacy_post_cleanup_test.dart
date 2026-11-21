import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:social_bird/db/app_database.dart';

void main() {
  test(
    'removes previously synced API posts during database migration',
    () async {
      final directory = await Directory.systemTemp.createTemp(
        'social_bird_post_migration_',
      );
      final file = File('${directory.path}\\socialbird.sqlite');

      var database = AppDatabase(executor: NativeDatabase(file));
      await database.insertPost(
        PostsCompanion.insert(
          id: 'remote-1',
          authorName: 'JSONPlaceholder User 1',
          authorHandle: '@apiuser1',
          content: 'Old API post',
          createdAt: DateTime(2000),
        ),
      );
      await database.insertPost(
        PostsCompanion.insert(
          id: 'local-post',
          authorName: 'Local User',
          authorHandle: '@local',
          content: 'Keep this local post',
          createdAt: DateTime(2026),
        ),
      );
      await database.customStatement('PRAGMA user_version = 2');
      await database.close();

      database = AppDatabase(executor: NativeDatabase(file));
      final posts = await database.watchPosts().first;

      expect(posts.map((post) => post.id), ['local-post']);
      await database.close();
      await directory.delete(recursive: true);
    },
  );
}
