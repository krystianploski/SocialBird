import '../db/app_database.dart';
import '../models/api_post_model.dart';
import '../models/post_model.dart';
import '../services/post_api_service.dart';

class PostRepository {
  PostRepository(this._database, this._apiService);

  final AppDatabase _database;
  final PostApiService _apiService;
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

  Future<int> syncRemotePosts() async {
    final remotePosts = await _apiService.fetchPosts();
    for (final remotePost in remotePosts) {
      await _database.upsertPost(_toLocalPost(remotePost));
    }
    return remotePosts.length;
  }

  PostsCompanion _toLocalPost(ApiPostModel post) {
    final content = '${post.title}\n\n${post.body}'.trim();
    return PostsCompanion.insert(
      id: 'remote-${post.id}',
      authorName: 'JSONPlaceholder User ${post.userId}',
      authorHandle: '@apiuser${post.userId}',
      content: content.length > PostModel.maxContentLength
          ? content.substring(0, PostModel.maxContentLength)
          : content,
      createdAt: DateTime.utc(2000),
    );
  }
}
