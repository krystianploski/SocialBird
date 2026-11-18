import 'package:flutter/foundation.dart';

import '../models/quote_model.dart';
import '../repositories/quote_repository.dart';

class QuoteViewModel extends ChangeNotifier {
  QuoteViewModel({required this.quoteRepository});

  final QuoteRepository quoteRepository;

  QuoteModel? quote;
  bool isLoading = true;
  bool hasError = false;
  int _requestId = 0;

  Future<void> fetchRandomQuote() async {
    final requestId = ++_requestId;
    isLoading = true;
    hasError = false;
    notifyListeners();

    try {
      final newQuote = await quoteRepository.fetchRandomQuote();
      if (requestId != _requestId) return;
      quote = newQuote;
    } on QuoteRepositoryException {
      if (requestId != _requestId) return;
      hasError = true;
    } finally {
      if (requestId == _requestId) {
        isLoading = false;
        notifyListeners();
      }
    }
  }
}
