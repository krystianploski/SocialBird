import 'package:flutter/foundation.dart';

import '../models/post_model.dart';
import '../services/post_service.dart';
import '../services/user_service.dart';

class PostViewModel extends ChangeNotifier {
  PostViewModel({
    required this.postService,
    required this.userService,
  });

  final PostService postService;
  final UserService userService;

  late final Stream<List<PostModel>> posts = postService.watchPosts();

  Future<void> createPost(String content) async {
    final user = userService.currentUser;
    if (user == null) {
      throw StateError('A user must be logged in to create a post.');
    }

    await postService.insertPost(
      content: content,
      authorName: user.username,
      authorHandle: '@${user.username.toLowerCase()}',
    );
  }
}
