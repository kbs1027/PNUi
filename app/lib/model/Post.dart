class PostFields {
  static const String id = 'id';
  static const String link = 'link';
  static const String title = 'title';
  static const String content = 'content';
}

class Post {
  static String tablename = 'Posts';
  final int? id;
  String? title;
  String? link;
  String? content;

  Post({
    this.id,
    required this.title,
    required this.link,
    required this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      PostFields.link: link,
      PostFields.title: title,
      PostFields.content: content,
    };
  }

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        link: json['link'],
        title: json['title'],
        content: json['content'],
      );
}
