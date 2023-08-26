class PostFields {
  static const String id = 'id';
  static const String title = 'title';
  static const String content = 'content';
}

class Post {
  static String tablename = 'Posts';
  final int? id;
  String? title;
  String? content;

  Post({
    this.id,
    required this.title,
    required this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      PostFields.title: title,
      PostFields.content: content,
    };
  }

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        title: json['title'],
        content: json['content'],
      );
}
