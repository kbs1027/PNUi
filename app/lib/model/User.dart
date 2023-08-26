class UserFields {
  static const String id = 'id';
  static const String department = 'department';
  static const String subscribes = 'subscribes';
  static const String favorite = 'favorite';
}

class User {
  static String tablename = 'User';
  final int? id;
  int? department;
  List<int>? subscribes;
  List<int>? favorite;

  User({
    this.id,
    required this.department,
    this.subscribes,
    this.favorite,
  });

  Map<String, dynamic> toJson() {
    return {
      UserFields.department: department,
      UserFields.subscribes: subscribes,
      UserFields.favorite: favorite
    };
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        department: json['department'],
        subscribes: json['subscribes'],
        favorite: json['favorite'],
      );
}
