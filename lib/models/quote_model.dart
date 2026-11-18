class QuoteModel {
  const QuoteModel({
    required this.id,
    required this.content,
    required this.author,
  });

  final int id;
  final String content;
  final String author;

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final content = json['quote'];
    final author = json['author'];
    if (id is! int ||
        content is! String ||
        content.trim().isEmpty ||
        author is! String ||
        author.trim().isEmpty) {
      throw const FormatException('Invalid quote data.');
    }

    return QuoteModel(id: id, content: content, author: author);
  }
}
