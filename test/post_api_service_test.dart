import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:social_bird/models/api_post_model.dart';
import 'package:social_bird/services/post_api_service.dart';

void main() {
  test('parses posts from the API', () async {
    final service = PostApiService(
      dio: _dio('[{"userId":1,"id":2,"title":"Hello","body":"Post body"}]'),
    );
    addTearDown(service.close);

    final posts = await service.fetchPosts();

    expect(posts, [
      isA<ApiPostModel>()
          .having((post) => post.userId, 'userId', 1)
          .having((post) => post.id, 'id', 2)
          .having((post) => post.title, 'title', 'Hello')
          .having((post) => post.body, 'body', 'Post body'),
    ]);
  });

  test('reports HTTP failures as API errors', () async {
    final service = PostApiService(dio: _dio('{}', statusCode: 500));
    addTearDown(service.close);

    await expectLater(
      service.fetchPosts(),
      throwsA(
        isA<PostApiException>().having(
          (error) => error.message,
          'message',
          'Serwer zwrócił błąd (500).',
        ),
      ),
    );
  });

  test('reports malformed post data as an API error', () async {
    final service = PostApiService(dio: _dio('[{"id":"invalid"}]'));
    addTearDown(service.close);

    await expectLater(service.fetchPosts(), throwsA(isA<PostApiException>()));
  });
}

Dio _dio(String responseBody, {int statusCode = 200}) {
  return Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'))
    ..httpClientAdapter = _TestAdapter(responseBody, statusCode);
}

class _TestAdapter implements HttpClientAdapter {
  _TestAdapter(this.responseBody, this.statusCode);

  final String responseBody;
  final int statusCode;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    return ResponseBody.fromString(
      responseBody,
      statusCode,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}
