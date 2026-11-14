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

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _normalizedUsernameMeta =
      const VerificationMeta('normalizedUsername');
  @override
  late final GeneratedColumn<String> normalizedUsername =
      GeneratedColumn<String>(
        'normalized_username',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
      );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _normalizedEmailMeta = const VerificationMeta(
    'normalizedEmail',
  );
  @override
  late final GeneratedColumn<String> normalizedEmail = GeneratedColumn<String>(
    'normalized_email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _passwordHashMeta = const VerificationMeta(
    'passwordHash',
  );
  @override
  late final GeneratedColumn<String> passwordHash = GeneratedColumn<String>(
    'password_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _passwordSaltMeta = const VerificationMeta(
    'passwordSalt',
  );
  @override
  late final GeneratedColumn<String> passwordSalt = GeneratedColumn<String>(
    'password_salt',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    username,
    normalizedUsername,
    email,
    normalizedEmail,
    passwordHash,
    passwordSalt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('normalized_username')) {
      context.handle(
        _normalizedUsernameMeta,
        normalizedUsername.isAcceptableOrUnknown(
          data['normalized_username']!,
          _normalizedUsernameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_normalizedUsernameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('normalized_email')) {
      context.handle(
        _normalizedEmailMeta,
        normalizedEmail.isAcceptableOrUnknown(
          data['normalized_email']!,
          _normalizedEmailMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_normalizedEmailMeta);
    }
    if (data.containsKey('password_hash')) {
      context.handle(
        _passwordHashMeta,
        passwordHash.isAcceptableOrUnknown(
          data['password_hash']!,
          _passwordHashMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_passwordHashMeta);
    }
    if (data.containsKey('password_salt')) {
      context.handle(
        _passwordSaltMeta,
        passwordSalt.isAcceptableOrUnknown(
          data['password_salt']!,
          _passwordSaltMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_passwordSaltMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      )!,
      normalizedUsername: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}normalized_username'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      normalizedEmail: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}normalized_email'],
      )!,
      passwordHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password_hash'],
      )!,
      passwordSalt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password_salt'],
      )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String username;
  final String normalizedUsername;
  final String email;
  final String normalizedEmail;
  final String passwordHash;
  final String passwordSalt;
  const User({
    required this.id,
    required this.username,
    required this.normalizedUsername,
    required this.email,
    required this.normalizedEmail,
    required this.passwordHash,
    required this.passwordSalt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['username'] = Variable<String>(username);
    map['normalized_username'] = Variable<String>(normalizedUsername);
    map['email'] = Variable<String>(email);
    map['normalized_email'] = Variable<String>(normalizedEmail);
    map['password_hash'] = Variable<String>(passwordHash);
    map['password_salt'] = Variable<String>(passwordSalt);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      username: Value(username),
      normalizedUsername: Value(normalizedUsername),
      email: Value(email),
      normalizedEmail: Value(normalizedEmail),
      passwordHash: Value(passwordHash),
      passwordSalt: Value(passwordSalt),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      normalizedUsername: serializer.fromJson<String>(
        json['normalizedUsername'],
      ),
      email: serializer.fromJson<String>(json['email']),
      normalizedEmail: serializer.fromJson<String>(json['normalizedEmail']),
      passwordHash: serializer.fromJson<String>(json['passwordHash']),
      passwordSalt: serializer.fromJson<String>(json['passwordSalt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'username': serializer.toJson<String>(username),
      'normalizedUsername': serializer.toJson<String>(normalizedUsername),
      'email': serializer.toJson<String>(email),
      'normalizedEmail': serializer.toJson<String>(normalizedEmail),
      'passwordHash': serializer.toJson<String>(passwordHash),
      'passwordSalt': serializer.toJson<String>(passwordSalt),
    };
  }

  User copyWith({
    int? id,
    String? username,
    String? normalizedUsername,
    String? email,
    String? normalizedEmail,
    String? passwordHash,
    String? passwordSalt,
  }) => User(
    id: id ?? this.id,
    username: username ?? this.username,
    normalizedUsername: normalizedUsername ?? this.normalizedUsername,
    email: email ?? this.email,
    normalizedEmail: normalizedEmail ?? this.normalizedEmail,
    passwordHash: passwordHash ?? this.passwordHash,
    passwordSalt: passwordSalt ?? this.passwordSalt,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
      normalizedUsername: data.normalizedUsername.present
          ? data.normalizedUsername.value
          : this.normalizedUsername,
      email: data.email.present ? data.email.value : this.email,
      normalizedEmail: data.normalizedEmail.present
          ? data.normalizedEmail.value
          : this.normalizedEmail,
      passwordHash: data.passwordHash.present
          ? data.passwordHash.value
          : this.passwordHash,
      passwordSalt: data.passwordSalt.present
          ? data.passwordSalt.value
          : this.passwordSalt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('normalizedUsername: $normalizedUsername, ')
          ..write('email: $email, ')
          ..write('normalizedEmail: $normalizedEmail, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('passwordSalt: $passwordSalt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    username,
    normalizedUsername,
    email,
    normalizedEmail,
    passwordHash,
    passwordSalt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.username == this.username &&
          other.normalizedUsername == this.normalizedUsername &&
          other.email == this.email &&
          other.normalizedEmail == this.normalizedEmail &&
          other.passwordHash == this.passwordHash &&
          other.passwordSalt == this.passwordSalt);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> username;
  final Value<String> normalizedUsername;
  final Value<String> email;
  final Value<String> normalizedEmail;
  final Value<String> passwordHash;
  final Value<String> passwordSalt;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.normalizedUsername = const Value.absent(),
    this.email = const Value.absent(),
    this.normalizedEmail = const Value.absent(),
    this.passwordHash = const Value.absent(),
    this.passwordSalt = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String username,
    required String normalizedUsername,
    required String email,
    required String normalizedEmail,
    required String passwordHash,
    required String passwordSalt,
  }) : username = Value(username),
       normalizedUsername = Value(normalizedUsername),
       email = Value(email),
       normalizedEmail = Value(normalizedEmail),
       passwordHash = Value(passwordHash),
       passwordSalt = Value(passwordSalt);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? username,
    Expression<String>? normalizedUsername,
    Expression<String>? email,
    Expression<String>? normalizedEmail,
    Expression<String>? passwordHash,
    Expression<String>? passwordSalt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (normalizedUsername != null) 'normalized_username': normalizedUsername,
      if (email != null) 'email': email,
      if (normalizedEmail != null) 'normalized_email': normalizedEmail,
      if (passwordHash != null) 'password_hash': passwordHash,
      if (passwordSalt != null) 'password_salt': passwordSalt,
    });
  }

  UsersCompanion copyWith({
    Value<int>? id,
    Value<String>? username,
    Value<String>? normalizedUsername,
    Value<String>? email,
    Value<String>? normalizedEmail,
    Value<String>? passwordHash,
    Value<String>? passwordSalt,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      normalizedUsername: normalizedUsername ?? this.normalizedUsername,
      email: email ?? this.email,
      normalizedEmail: normalizedEmail ?? this.normalizedEmail,
      passwordHash: passwordHash ?? this.passwordHash,
      passwordSalt: passwordSalt ?? this.passwordSalt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (normalizedUsername.present) {
      map['normalized_username'] = Variable<String>(normalizedUsername.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (normalizedEmail.present) {
      map['normalized_email'] = Variable<String>(normalizedEmail.value);
    }
    if (passwordHash.present) {
      map['password_hash'] = Variable<String>(passwordHash.value);
    }
    if (passwordSalt.present) {
      map['password_salt'] = Variable<String>(passwordSalt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('normalizedUsername: $normalizedUsername, ')
          ..write('email: $email, ')
          ..write('normalizedEmail: $normalizedEmail, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('passwordSalt: $passwordSalt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PostsTable posts = $PostsTable(this);
  late final $UsersTable users = $UsersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [posts, users];
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
typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  required String username,
  required String normalizedUsername,
  required String email,
  required String normalizedEmail,
  required String passwordHash,
  required String passwordSalt,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  Value<String> username,
  Value<String> normalizedUsername,
  Value<String> email,
  Value<String> normalizedEmail,
  Value<String> passwordHash,
  Value<String> passwordSalt,
});

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get normalizedUsername => $composableBuilder(
    column: $table.normalizedUsername,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get normalizedEmail => $composableBuilder(
    column: $table.normalizedEmail,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get passwordSalt => $composableBuilder(
    column: $table.passwordSalt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get normalizedUsername => $composableBuilder(
    column: $table.normalizedUsername,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get normalizedEmail => $composableBuilder(
    column: $table.normalizedEmail,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get passwordSalt => $composableBuilder(
    column: $table.passwordSalt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get normalizedUsername => $composableBuilder(
    column: $table.normalizedUsername,
    builder: (column) => column,
  );

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get normalizedEmail => $composableBuilder(
    column: $table.normalizedEmail,
    builder: (column) => column,
  );

  GeneratedColumn<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => column,
  );

  GeneratedColumn<String> get passwordSalt => $composableBuilder(
    column: $table.passwordSalt,
    builder: (column) => column,
  );
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
          User,
          PrefetchHooks Function()
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> username = const Value.absent(),
                Value<String> normalizedUsername = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> normalizedEmail = const Value.absent(),
                Value<String> passwordHash = const Value.absent(),
                Value<String> passwordSalt = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                username: username,
                normalizedUsername: normalizedUsername,
                email: email,
                normalizedEmail: normalizedEmail,
                passwordHash: passwordHash,
                passwordSalt: passwordSalt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String username,
                required String normalizedUsername,
                required String email,
                required String normalizedEmail,
                required String passwordHash,
                required String passwordSalt,
              }) => UsersCompanion.insert(
                id: id,
                username: username,
                normalizedUsername: normalizedUsername,
                email: email,
                normalizedEmail: normalizedEmail,
                passwordHash: passwordHash,
                passwordSalt: passwordSalt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UsersTable, User>(table),
                  BaseReferences<_$AppDatabase, $UsersTable, User>(
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

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
      User,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PostsTableTableManager get posts =>
      $$PostsTableTableManager(_db, _db.posts);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
}
