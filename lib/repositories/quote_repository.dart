import '../models/quote_model.dart';
import '../services/quote_api_service.dart';

class QuoteRepositoryException implements Exception {
  const QuoteRepositoryException(this.message);

  final String message;
}

class QuoteRepository {
  QuoteRepository(this._apiService);

  final QuoteApiService _apiService;

  Future<QuoteModel> fetchRandomQuote() async {
    try {
      return await _apiService.fetchRandomQuote();
    } on QuoteApiException catch (error) {
      throw QuoteRepositoryException(error.message);
    }
  }
}
