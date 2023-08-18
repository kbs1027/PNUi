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

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'RssData': RssData,
      'Posts': Posts,
    };
  }

  // 데이터베이스에서 가져온 데이터를 RssData 객체로 변환하는 메서드를 추가합니다.
  factory Board.fromMap(Map<String, dynamic> json) {
    return Board(
      name: json['name'],
      RssData: json['RssData'],
      Posts: json['Posts'],
    );
  }
}
