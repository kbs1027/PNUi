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

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'contet': content,
    };
  }

  static Post fromMap(Map<String, dynamic> map) {
    return Post(
      title: map['title'],
      content: map['content'],
    );
  }
}
