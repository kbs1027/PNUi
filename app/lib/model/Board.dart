class BoardFields {
  static const String id = 'id';
  static const String name = 'name';
  static const String RssData = 'RssData';
  static const String Posts = 'Posts';
}

class Board {
  static String tablename = 'Boards';
  final int? id;
  String? name;
  String? RssData;
  List<int>? Posts;

  Board({
    this.id,
    required this.name,
    required this.RssData,
    required this.Posts,
  });

  Map<String, dynamic> toJson() {
    return {
      BoardFields.name: name,
      BoardFields.RssData: RssData,
      BoardFields.Posts: Posts,
    };
  }

  factory Board.fromJson(Map<String, dynamic> json) => Board(
        id: json[BoardFields.id], // 여기서 id를 추가해줘야 합니다.
        name: json[BoardFields.name],
        RssData: json[BoardFields.RssData],
        Posts: List<int>.from(json[BoardFields.Posts]),
      );

  void updatePosts(List<int> newPosts) {
    Posts = newPosts;
  }
}
