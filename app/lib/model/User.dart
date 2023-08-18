class UserFields {
  static const String id = 'id';
  static const String department = 'department';
  static const String subscribe = 'subscribe';
  static const String favorite = 'favorite';
}

class User {
  static String tablename = 'User';
  final int? id;
  int? department;
  List<int>? subscribe;
  List<int>? favorite;

  User({
    this.id,
    required this.department,
    this.subscribe,
    this.favorite,
  });

  Map<String, dynamic> toMap() {
    return {
      'department': department,
      'subscribe': subscribe,
      'favorite': favorite,
    };
  }
}
