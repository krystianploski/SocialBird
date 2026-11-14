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

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get username => text()();

  TextColumn get normalizedUsername => text().unique()();

  TextColumn get email => text()();

  TextColumn get normalizedEmail => text().unique()();

  TextColumn get passwordHash => text()();

  TextColumn get passwordSalt => text()();
}

@DriftDatabase(tables: [Posts, Users])
class AppDatabase extends _$AppDatabase {
  AppDatabase({QueryExecutor? executor}) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.createTable(users);
      }
    },
  );

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

  Future<User?> getUserByEmail(String normalizedEmail) {
    return (select(users)
          ..where((user) => user.normalizedEmail.equals(normalizedEmail)))
        .getSingleOrNull();
  }

  Future<bool> userExists({
    required String normalizedEmail,
    required String normalizedUsername,
  }) async {
    final matches =
        await (select(users)..where(
              (user) =>
                  user.normalizedEmail.equals(normalizedEmail) |
                  user.normalizedUsername.equals(normalizedUsername),
            ))
            .get();
    return matches.isNotEmpty;
  }

  Future<int> insertUser(UsersCompanion user) {
    return into(users).insert(user);
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'socialbird.sqlite'));

    return NativeDatabase(file);
  });
}
