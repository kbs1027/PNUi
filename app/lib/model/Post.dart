class PostFields {
  static const String id = 'id';
  static const String link = 'link';
  static const String title = 'title';
  static const String pubDate = 'pubDate';
  static const String content = 'content';
}

class Post {
  static String tablename = 'Posts';
  final int? id;
  String? title;
  String? link;
  String? pubDate;
  String? content;

  Post({
    this.id,
    required this.title,
    required this.link,
    required this.pubDate,
    required this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      PostFields.link: link,
      PostFields.title: title,
      PostFields.pubDate: pubDate,
      PostFields.content: content,
    };
  }

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        link: json['link'],
        title: json['title'],
        pubDate: json['pubDate'],
        content: json['content'],
      );
}
