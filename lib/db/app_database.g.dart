// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PostsTable extends Posts with TableInfo<$PostsTable, Post> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PostsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _authorNameMeta = const VerificationMeta(
    'authorName',
  );
  @override
  late final GeneratedColumn<String> authorName = GeneratedColumn<String>(
    'author_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _authorHandleMeta = const VerificationMeta(
    'authorHandle',
  );
  @override
  late final GeneratedColumn<String> authorHandle = GeneratedColumn<String>(
    'author_handle',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _likesCountMeta = const VerificationMeta(
    'likesCount',
  );
  @override
  late final GeneratedColumn<int> likesCount = GeneratedColumn<int>(
    'likes_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isLikedMeta = const VerificationMeta(
    'isLiked',
  );
  @override
  late final GeneratedColumn<bool> isLiked = GeneratedColumn<bool>(
    'is_liked',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_liked" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    authorName,
    authorHandle,
    content,
    createdAt,
    likesCount,
    isLiked,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'posts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Post> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('author_name')) {
      context.handle(
        _authorNameMeta,
        authorName.isAcceptableOrUnknown(data['author_name']!, _authorNameMeta),
      );
    } else if (isInserting) {
      context.missing(_authorNameMeta);
    }
    if (data.containsKey('author_handle')) {
      context.handle(
        _authorHandleMeta,
        authorHandle.isAcceptableOrUnknown(
          data['author_handle']!,
          _authorHandleMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_authorHandleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('likes_count')) {
      context.handle(
        _likesCountMeta,
        likesCount.isAcceptableOrUnknown(data['likes_count']!, _likesCountMeta),
      );
    }
    if (data.containsKey('is_liked')) {
      context.handle(
        _isLikedMeta,
        isLiked.isAcceptableOrUnknown(data['is_liked']!, _isLikedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Post map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Post(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      authorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author_name'],
      )!,
      authorHandle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author_handle'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      likesCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}likes_count'],
      )!,
      isLiked: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_liked'],
      )!,
    );
  }

  @override
  $PostsTable createAlias(String alias) {
    return $PostsTable(attachedDatabase, alias);
  }
}

class Post extends DataClass implements Insertable<Post> {
  final String id;
  final String authorName;
  final String authorHandle;
  final String content;
  final DateTime createdAt;
  final int likesCount;
  final bool isLiked;
  const Post({
    required this.id,
    required this.authorName,
    required this.authorHandle,
    required this.content,
    required this.createdAt,
    required this.likesCount,
    required this.isLiked,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['author_name'] = Variable<String>(authorName);
    map['author_handle'] = Variable<String>(authorHandle);
    map['content'] = Variable<String>(content);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['likes_count'] = Variable<int>(likesCount);
    map['is_liked'] = Variable<bool>(isLiked);
    return map;
  }

  PostsCompanion toCompanion(bool nullToAbsent) {
    return PostsCompanion(
      id: Value(id),
      authorName: Value(authorName),
      authorHandle: Value(authorHandle),
      content: Value(content),
      createdAt: Value(createdAt),
      likesCount: Value(likesCount),
      isLiked: Value(isLiked),
    );
  }

  factory Post.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Post(
      id: serializer.fromJson<String>(json['id']),
      authorName: serializer.fromJson<String>(json['authorName']),
      authorHandle: serializer.fromJson<String>(json['authorHandle']),
      content: serializer.fromJson<String>(json['content']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      likesCount: serializer.fromJson<int>(json['likesCount']),
      isLiked: serializer.fromJson<bool>(json['isLiked']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'authorName': serializer.toJson<String>(authorName),
      'authorHandle': serializer.toJson<String>(authorHandle),
      'content': serializer.toJson<String>(content),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'likesCount': serializer.toJson<int>(likesCount),
      'isLiked': serializer.toJson<bool>(isLiked),
    };
  }

  Post copyWith({
    String? id,
    String? authorName,
    String? authorHandle,
    String? content,
    DateTime? createdAt,
    int? likesCount,
    bool? isLiked,
  }) => Post(
    id: id ?? this.id,
    authorName: authorName ?? this.authorName,
    authorHandle: authorHandle ?? this.authorHandle,
    content: content ?? this.content,
    createdAt: createdAt ?? this.createdAt,
    likesCount: likesCount ?? this.likesCount,
    isLiked: isLiked ?? this.isLiked,
  );
  Post copyWithCompanion(PostsCompanion data) {
    return Post(
      id: data.id.present ? data.id.value : this.id,
      authorName: data.authorName.present
          ? data.authorName.value
          : this.authorName,
      authorHandle: data.authorHandle.present
          ? data.authorHandle.value
          : this.authorHandle,
      content: data.content.present ? data.content.value : this.content,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      likesCount: data.likesCount.present
          ? data.likesCount.value
          : this.likesCount,
      isLiked: data.isLiked.present ? data.isLiked.value : this.isLiked,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Post(')
          ..write('id: $id, ')
          ..write('authorName: $authorName, ')
          ..write('authorHandle: $authorHandle, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('likesCount: $likesCount, ')
          ..write('isLiked: $isLiked')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    authorName,
    authorHandle,
    content,
    createdAt,
    likesCount,
    isLiked,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Post &&
          other.id == this.id &&
          other.authorName == this.authorName &&
          other.authorHandle == this.authorHandle &&
          other.content == this.content &&
          other.createdAt == this.createdAt &&
          other.likesCount == this.likesCount &&
          other.isLiked == this.isLiked);
}

class PostsCompanion extends UpdateCompanion<Post> {
  final Value<String> id;
  final Value<String> authorName;
  final Value<String> authorHandle;
  final Value<String> content;
  final Value<DateTime> createdAt;
  final Value<int> likesCount;
  final Value<bool> isLiked;
  final Value<int> rowid;
  const PostsCompanion({
    this.id = const Value.absent(),
    this.authorName = const Value.absent(),
    this.authorHandle = const Value.absent(),
    this.content = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.likesCount = const Value.absent(),
    this.isLiked = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PostsCompanion.insert({
    required String id,
    required String authorName,
    required String authorHandle,
    required String content,
    required DateTime createdAt,
    this.likesCount = const Value.absent(),
    this.isLiked = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       authorName = Value(authorName),
       authorHandle = Value(authorHandle),
       content = Value(content),
       createdAt = Value(createdAt);
  static Insertable<Post> custom({
    Expression<String>? id,
    Expression<String>? authorName,
    Expression<String>? authorHandle,
    Expression<String>? content,
    Expression<DateTime>? createdAt,
    Expression<int>? likesCount,
    Expression<bool>? isLiked,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (authorName != null) 'author_name': authorName,
      if (authorHandle != null) 'author_handle': authorHandle,
      if (content != null) 'content': content,
      if (createdAt != null) 'created_at': createdAt,
      if (likesCount != null) 'likes_count': likesCount,
      if (isLiked != null) 'is_liked': isLiked,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PostsCompanion copyWith({
    Value<String>? id,
    Value<String>? authorName,
    Value<String>? authorHandle,
    Value<String>? content,
    Value<DateTime>? createdAt,
    Value<int>? likesCount,
    Value<bool>? isLiked,
    Value<int>? rowid,
  }) {
    return PostsCompanion(
      id: id ?? this.id,
      authorName: authorName ?? this.authorName,
      authorHandle: authorHandle ?? this.authorHandle,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      likesCount: likesCount ?? this.likesCount,
      isLiked: isLiked ?? this.isLiked,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (authorName.present) {
      map['author_name'] = Variable<String>(authorName.value);
    }
    if (authorHandle.present) {
      map['author_handle'] = Variable<String>(authorHandle.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (likesCount.present) {
      map['likes_count'] = Variable<int>(likesCount.value);
    }
    if (isLiked.present) {
      map['is_liked'] = Variable<bool>(isLiked.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PostsCompanion(')
          ..write('id: $id, ')
          ..write('authorName: $authorName, ')
          ..write('authorHandle: $authorHandle, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('likesCount: $likesCount, ')
          ..write('isLiked: $isLiked, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PostsTable posts = $PostsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [posts];
}

typedef $$PostsTableCreateCompanionBuilder = PostsCompanion Function({
  required String id,
  required String authorName,
  required String authorHandle,
  required String content,
  required DateTime createdAt,
  Value<int> likesCount,
  Value<bool> isLiked,
  Value<int> rowid,
});
typedef $$PostsTableUpdateCompanionBuilder = PostsCompanion Function({
  Value<String> id,
  Value<String> authorName,
  Value<String> authorHandle,
  Value<String> content,
  Value<DateTime> createdAt,
  Value<int> likesCount,
  Value<bool> isLiked,
  Value<int> rowid,
});

class $$PostsTableFilterComposer extends Composer<_$AppDatabase, $PostsTable> {
  $$PostsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get authorName => $composableBuilder(
    column: $table.authorName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get authorHandle => $composableBuilder(
    column: $table.authorHandle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get likesCount => $composableBuilder(
    column: $table.likesCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isLiked => $composableBuilder(
    column: $table.isLiked,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PostsTableOrderingComposer
    extends Composer<_$AppDatabase, $PostsTable> {
  $$PostsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get authorName => $composableBuilder(
    column: $table.authorName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get authorHandle => $composableBuilder(
    column: $table.authorHandle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get likesCount => $composableBuilder(
    column: $table.likesCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isLiked => $composableBuilder(
    column: $table.isLiked,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PostsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PostsTable> {
  $$PostsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get authorName => $composableBuilder(
    column: $table.authorName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get authorHandle => $composableBuilder(
    column: $table.authorHandle,
    builder: (column) => column,
  );

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get likesCount => $composableBuilder(
    column: $table.likesCount,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isLiked =>
      $composableBuilder(column: $table.isLiked, builder: (column) => column);
}

class $$PostsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PostsTable,
          Post,
          $$PostsTableFilterComposer,
          $$PostsTableOrderingComposer,
          $$PostsTableAnnotationComposer,
          $$PostsTableCreateCompanionBuilder,
          $$PostsTableUpdateCompanionBuilder,
          (Post, BaseReferences<_$AppDatabase, $PostsTable, Post>),
          Post,
          PrefetchHooks Function()
        > {
  $$PostsTableTableManager(_$AppDatabase db, $PostsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PostsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PostsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PostsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> authorName = const Value.absent(),
                Value<String> authorHandle = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> likesCount = const Value.absent(),
                Value<bool> isLiked = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PostsCompanion(
                id: id,
                authorName: authorName,
                authorHandle: authorHandle,
                content: content,
                createdAt: createdAt,
                likesCount: likesCount,
                isLiked: isLiked,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String authorName,
                required String authorHandle,
                required String content,
                required DateTime createdAt,
                Value<int> likesCount = const Value.absent(),
                Value<bool> isLiked = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PostsCompanion.insert(
                id: id,
                authorName: authorName,
                authorHandle: authorHandle,
                content: content,
                createdAt: createdAt,
                likesCount: likesCount,
                isLiked: isLiked,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PostsTable, Post>(table),
                  BaseReferences<_$AppDatabase, $PostsTable, Post>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PostsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PostsTable,
      Post,
      $$PostsTableFilterComposer,
      $$PostsTableOrderingComposer,
      $$PostsTableAnnotationComposer,
      $$PostsTableCreateCompanionBuilder,
      $$PostsTableUpdateCompanionBuilder,
      (Post, BaseReferences<_$AppDatabase, $PostsTable, Post>),
      Post,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PostsTableTableManager get posts =>
      $$PostsTableTableManager(_db, _db.posts);
}
