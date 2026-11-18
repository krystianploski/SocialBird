class ApiPostModel {
  const ApiPostModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  final int userId;
  final int id;
  final String title;
  final String body;

  factory ApiPostModel.fromJson(Map<String, dynamic> json) {
    final userId = json['userId'];
    final id = json['id'];
    final title = json['title'];
    final body = json['body'];
    if (userId is! int || id is! int || title is! String || body is! String) {
      throw const FormatException('Invalid post data.');
    }

    return ApiPostModel(userId: userId, id: id, title: title, body: body);
  }
}
