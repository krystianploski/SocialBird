import 'package:flutter/foundation.dart';

import '../models/post_model.dart';
import '../services/post_service.dart';
import '../services/user_service.dart';

class PostViewModel extends ChangeNotifier {
  PostViewModel({PostService? postService, UserService? userService})
    : _postService = postService ?? PostService(),
      _userService = userService ?? UserService();

  final PostService _postService;
  final UserService _userService;

  late final Stream<List<PostModel>> posts = _postService.watchPosts();

  Future<void> createPost(String content) async {
    final user = _userService.currentUser;
    if (user == null) {
      throw StateError('A user must be logged in to create a post.');
    }

    await _postService.insertPost(
      content: content,
      authorName: user.username,
      authorHandle: '@${user.username.toLowerCase()}',
    );
  }
}
