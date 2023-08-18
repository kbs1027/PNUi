class DepartmentFields {
  static const String id = 'id';
  static const String major = 'major';
  static const String Boards = 'Boards';
}

class Department {
  static String tablename = 'Departments';
  final int? id;
  String? major;
  List<int>? Boards;

  Department({
    this.id,
    required this.major,
    required this.Boards,
  });

  Map<String, dynamic> toMap() {
    return {
      'major': major,
      'Boards': Boards,
    };
  }

  factory Department.fromJson(Map<String, dynamic> json) => Department(
        major: json['major'],
        Boards: json['Boards'],
      );
}
