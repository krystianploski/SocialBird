import '../models/post_model.dart';

class PostService {
  final List<PostModel> _posts = [];
  static int _nextId = 0;

  List<PostModel> getPosts() => List.unmodifiable(_posts);

  PostModel addPost({
    required String content,
    required String authorName,
    required String authorHandle,
  }) {
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
    _posts.insert(0, post);
    return post;
  }
}
