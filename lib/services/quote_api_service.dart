import 'package:dio/dio.dart';

import '../models/quote_model.dart';

class QuoteApiException implements Exception {
  const QuoteApiException(this.message);

  final String message;

  @override
  String toString() => message;
}

class QuoteApiService {
  QuoteApiService({Dio? dio})
    : _dio = dio ?? Dio(BaseOptions(baseUrl: 'https://dummyjson.com'));

  final Dio _dio;

  Future<QuoteModel> fetchRandomQuote() async {
    try {
      final response = await _dio.get<dynamic>('/quotes/random');
      final data = response.data;
      if (data is! Map<String, dynamic>) {
        throw const FormatException('Invalid quote response.');
      }

      return QuoteModel.fromJson(data);
    } on DioException catch (error) {
      throw QuoteApiException(
        error.response == null
            ? 'Nie udało się połączyć z serwerem.'
            : 'Serwer zwrócił błąd (${error.response?.statusCode}).',
      );
    } on FormatException {
      throw const QuoteApiException('Serwer zwrócił nieprawidłowe dane.');
    }
  }

  void close() {
    _dio.close();
  }
}
