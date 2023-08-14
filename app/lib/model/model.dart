class RssData {
  final int? id;
  final String department;
  final String noticeMenu;
  final String Rss;

  RssData({
    this.id,
    required this.department,
    required this.noticeMenu,
    required this.Rss,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'department': department,
      'noticeMenu': noticeMenu,
      'Rss': Rss,
    };
  }

  // 데이터베이스에서 가져온 데이터를 RssData 객체로 변환하는 메서드를 추가합니다.
  static RssData fromMap(Map<String, dynamic> map) {
    return RssData(
      id: map['id'],
      department: map['department'],
      noticeMenu: map['noticeMenu'],
      Rss: map['Rss'],
    );
  }
}
