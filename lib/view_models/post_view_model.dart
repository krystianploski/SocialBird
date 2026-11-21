import 'package:flutter/foundation.dart';

import '../models/post_model.dart';
import '../repositories/post_repository.dart';
import '../services/user_service.dart';

class PostViewModel extends ChangeNotifier {
  PostViewModel({required this.postRepository, required this.userService});

  final PostRepository postRepository;
  final UserService userService;

  late final Stream<List<PostModel>> posts = postRepository.watchPosts();

  Future<void> createPost(String content) async {
    final user = userService.currentUser;
    if (user == null) {
      throw StateError('A user must be logged in to create a post.');
    }

    await postRepository.insertPost(
      content: content,
      authorName: user.username,
      authorHandle: '@${user.username.toLowerCase()}',
    );
  }
}
