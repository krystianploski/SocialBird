import '../db/app_database.dart';
import '../models/post_model.dart';

class PostService {
  PostService({AppDatabase? database}) : _database = database ?? AppDatabase();

  final AppDatabase _database;
  static int _nextId = 0;

  Stream<List<PostModel>> watchPosts() {
    return _database.watchPosts().map(
      (posts) => posts
          .map(
            (post) => PostModel(
              id: post.id,
              authorName: post.authorName,
              authorHandle: post.authorHandle,
              content: post.content,
              createdAt: post.createdAt,
              likesCount: post.likesCount,
              isLiked: post.isLiked,
            ),
          )
          .toList(growable: false),
    );
  }

  Future<PostModel> insertPost({
    required String content,
    required String authorName,
    required String authorHandle,
  }) async {
    final normalizedContent = content.trim();
    if (normalizedContent.isEmpty) {
      throw ArgumentError.value(content, 'content', 'Post cannot be empty.');
    }
    if (normalizedContent.length > PostModel.maxContentLength) {
      throw ArgumentError.value(
        content,
        'content',
        'Post cannot exceed ${PostModel.maxContentLength} characters.',
      );
    }
    if (authorName.trim().isEmpty || authorHandle.trim().isEmpty) {
      throw ArgumentError('Post author name and handle are required.');
    }

    final createdAt = DateTime.now();
    final post = PostModel(
      id: '${createdAt.microsecondsSinceEpoch}-${_nextId++}',
      authorName: authorName.trim(),
      authorHandle: authorHandle.trim(),
      content: normalizedContent,
      createdAt: createdAt,
    );
    await _database.insertPost(
      PostsCompanion.insert(
        id: post.id,
        authorName: post.authorName,
        authorHandle: post.authorHandle,
        content: post.content,
        createdAt: post.createdAt,
      ),
    );
    return post;
  }

  Future<bool> deletePost(String id) async {
    return await _database.deletePost(id) > 0;
  }
}
