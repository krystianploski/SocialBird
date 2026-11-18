import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:social_bird/models/quote_model.dart';
import 'package:social_bird/repositories/quote_repository.dart';
import 'package:social_bird/services/quote_api_service.dart';

void main() {
  test('parses a random quote response', () async {
    final service = QuoteApiService(
      dio: _dio('{"id":42,"quote":"Keep going.","author":"Example Author"}'),
    );
    addTearDown(service.close);

    final repository = QuoteRepository(service);
    final quote = await repository.fetchRandomQuote();

    expect(quote, isA<QuoteModel>());
    expect(quote.id, 42);
    expect(quote.content, 'Keep going.');
    expect(quote.author, 'Example Author');
  });

  test('reports HTTP failures as quote API errors', () async {
    final service = QuoteApiService(dio: _dio('{}', statusCode: 500));
    addTearDown(service.close);

    await expectLater(
      service.fetchRandomQuote(),
      throwsA(
        isA<QuoteApiException>().having(
          (error) => error.message,
          'message',
          'Serwer zwrócił błąd (500).',
        ),
      ),
    );
  });

  test('reports malformed quote data as a quote API error', () async {
    final service = QuoteApiService(
      dio: _dio('{"id":"invalid","quote":"","author":4}'),
    );
    addTearDown(service.close);

    await expectLater(
      service.fetchRandomQuote(),
      throwsA(
        isA<QuoteApiException>().having(
          (error) => error.message,
          'message',
          'Serwer zwrócił nieprawidłowe dane.',
        ),
      ),
    );
  });
}

Dio _dio(String responseBody, {int statusCode = 200}) {
  return Dio(BaseOptions(baseUrl: 'https://dummyjson.com'))
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
