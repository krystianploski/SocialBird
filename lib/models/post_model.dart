class PostModel {
  static const maxContentLength = 280;

  final String id;
  final String authorName;
  final String authorHandle;
  final String content;
  final DateTime createdAt;
  final int likesCount;
  final bool isLiked;

  const PostModel({
    required this.id,
    required this.authorName,
    required this.authorHandle,
    required this.content,
    required this.createdAt,
    this.likesCount = 0,
    this.isLiked = false,
  });
}
