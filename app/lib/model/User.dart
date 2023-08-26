import 'package:app/model/Board.dart';
import 'package:app/model/Department.dart';
import 'package:app/model/Post.dart';

class UserFields {
  static const String id = 'id';
  static const String department = 'department';
  static const String subscribes = 'subscribes';
  static const String favorite = 'favorite';
}

class User {
  Department? department;
  List<Board>? subscribes;
  List<Post>? favorite;

  User._privateConstructor();

  static final User _instance = User._privateConstructor();

  static User get instance => _instance;
}
