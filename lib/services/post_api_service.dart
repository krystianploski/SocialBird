import 'package:dio/dio.dart';

import '../models/api_post_model.dart';

class PostApiException implements Exception {
  const PostApiException(this.message);

  final String message;

  @override
  String toString() => message;
}

class PostApiService {
  PostApiService({Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'),
          );

  final Dio _dio;

  Future<List<ApiPostModel>> fetchPosts() async {
    try {
      final response = await _dio.get<dynamic>('/posts');
      final data = response.data;
      if (data is! List) {
        throw const FormatException('Invalid post list.');
      }

      return data.map((item) {
        if (item is! Map<String, dynamic>) {
          throw const FormatException('Invalid post data.');
        }
        return ApiPostModel.fromJson(item);
      }).toList(growable: false);
    } on DioException catch (error) {
      throw PostApiException(
        error.response == null
            ? 'Nie udało się połączyć z serwerem.'
            : 'Serwer zwrócił błąd (${error.response?.statusCode}).',
      );
    } on FormatException {
      throw const PostApiException('Serwer zwrócił nieprawidłowe dane.');
    }
  }

  void close() {
    _dio.close();
  }
}
