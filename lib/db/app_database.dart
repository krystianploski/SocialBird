import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class Posts extends Table {
  TextColumn get id => text()();

  TextColumn get authorName => text()();

  TextColumn get authorHandle => text()();

  TextColumn get content => text()();

  DateTimeColumn get createdAt => dateTime()();

  IntColumn get likesCount => integer().withDefault(const Constant(0))();

  BoolColumn get isLiked => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Posts])
class AppDatabase extends _$AppDatabase {
  AppDatabase({QueryExecutor? executor}) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  Future<void> insertPost(PostsCompanion post) {
    return into(posts).insert(post);
  }

  Stream<List<Post>> watchPosts() {
    return (select(posts)..orderBy([
          (post) => OrderingTerm.desc(post.createdAt),
          (post) => OrderingTerm.desc(post.id),
        ]))
        .watch();
  }

  Future<int> deletePost(String id) {
    return (delete(posts)..where((post) => post.id.equals(id))).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'socialbird.sqlite'));

    return NativeDatabase(file);
  });
}
