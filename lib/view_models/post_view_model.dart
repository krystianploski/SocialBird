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

  List<PostModel> get posts => _postService.getPosts();

  void createPost(String content) {
    final user = _userService.currentUser;
    if (user == null) {
      throw StateError('A user must be logged in to create a post.');
    }

    _postService.addPost(
      content: content,
      authorName: user.username,
      authorHandle: '@${user.username.toLowerCase()}',
    );
    notifyListeners();
  }
}
