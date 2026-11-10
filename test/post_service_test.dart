import 'package:flutter_test/flutter_test.dart';
import 'package:social_bird/models/post_model.dart';
import 'package:social_bird/services/post_service.dart';

void main() {
  test('adds trimmed posts and returns newest posts first', () {
    final service = PostService();

    final firstPost = service.addPost(
      content: '  First post  ',
      authorName: ' Example User ',
      authorHandle: ' @example ',
    );
    final secondPost = service.addPost(
      content: 'Second post',
      authorName: 'Example User',
      authorHandle: '@example',
    );

    expect(firstPost.content, 'First post');
    expect(firstPost.authorName, 'Example User');
    expect(firstPost.authorHandle, '@example');
    expect(service.getPosts(), [secondPost, firstPost]);
  });

  test('rejects empty posts and posts over the content limit', () {
    final service = PostService();

    expect(
      () => service.addPost(
        content: '   ',
        authorName: 'Example User',
        authorHandle: '@example',
      ),
      throwsArgumentError,
    );
    expect(
      () => service.addPost(
        content: 'x' * (PostModel.maxContentLength + 1),
        authorName: 'Example User',
        authorHandle: '@example',
      ),
      throwsArgumentError,
    );
  });

  test('does not expose a mutable posts list', () {
    final service = PostService();
    final posts = service.getPosts();

    expect(() => posts.clear(), throwsUnsupportedError);
  });
}
