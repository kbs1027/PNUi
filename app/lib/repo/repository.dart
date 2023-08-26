import 'package:app/model/Board.dart';
import 'package:app/model/Department.dart';
import 'package:app/model/Post.dart';
import 'package:app/model/User.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDatabase {
  //db의 instance SqlDatabase.instance를 하는 것만으로 싱글톤
  static final SqlDatabase instance = SqlDatabase._instance();

  Database? _database;

  SqlDatabase._instance() {
    _initDataBase();
  }

  factory SqlDatabase() {
    return instance;
  }

  Future<void> _initDataBase() async {
    //각 폰의 db의 path를 가져온다
    var dataBasePath = await getDatabasesPath();
    //폰에 저장할 db의 path를 설정함
    String path = join(dataBasePath, 'pnu.db');
    _database = await openDatabase(
      //db의 path
      path,
      //스키마의 버전
      version: 1,
      //db가 없으면 실행되는 함수이다.
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    //db를 실행시킴
    await db.execute('''
    CREATE TABLE ${Department.tablename} (
      ${DepartmentFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${DepartmentFields.major} text not null,
      ${DepartmentFields.Boards} INTEGER,
      FOREIGN KEY(${DepartmentFields.Boards}) REFERENCES ${Board.tablename}(${BoardFields.id})
    )
  ''');

    await db.execute('''
    CREATE TABLE ${Board.tablename} (
      ${BoardFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${BoardFields.RssData} TEXT,
      ${BoardFields.name} TEXT,
      ${BoardFields.Posts} INTEGER,
      FOREIGN KEY(${BoardFields.Posts}) REFERENCES ${Post.tablename}(${PostFields.id})
    )
  ''');

    await db.execute('''
    CREATE TABLE ${Post.tablename} (
      ${PostFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${PostFields.title} TEXT not null,
      ${PostFields.content} TEXT not null
    )
  ''');
  }

  Future<int> insertDepartment(Department department) async {
    print("insert Department Data");
    print(department.major);
    print(department.Boards);
    return await _database!.insert(
      Department.tablename,
      department.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> insertBoard(Board board) async {
    print("data insert");

    // Check if a board with the same RssData and name already exists
    final List<Map<String, dynamic>> existingBoards = await _database!.query(
      Board.tablename,
      where: '${BoardFields.RssData} = ? AND ${BoardFields.name} = ?',
      whereArgs: [board.RssData, board.name],
    );

    if (existingBoards.isNotEmpty) {
      return existingBoards
          .first[BoardFields.id]; // Return the existing board's id
    }

    return await _database!.insert(
      Board.tablename,
      board.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> insertPost(Post post) async {
    return await _database!.insert(
      Post.tablename,
      post.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updatePost(Post post) async {
    return await _database!.update(
      Post.tablename,
      post.toJson(),
      where: '${PostFields.id} = ?',
      whereArgs: [post.id],
    );
  }

  Future<int> insertUser(User user) async {
    return await _database!.insert(
      User.tablename,
      user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateUserDepartment(User user) async {
    return await _database!.update(
      User.tablename,
      user.toJson(),
      where: '${UserFields.id} = ?',
      whereArgs: [user.id],
    );
  }

  Future<Department> getDepartmentByName(String name) async {
    final List<Map<String, dynamic>> maps = await _database!.query(
      Department.tablename,
      where: '${DepartmentFields.major} = ?',
      whereArgs: [name],
    );

    if (maps.isNotEmpty) {
      return Department.fromJson(maps.first);
    }

    return Department.fromJson(maps
        .first); // Return null if no department found with the specified name
  }

  Future<List<int?>?> getBoardsByDepartmentName(String name) async {
    Department department = await instance.getDepartmentByName(name);

    return department.Boards;
  }

  Future<void> deleteAllBoards() async {
    await _database!.delete(Board.tablename);
  }

  Future<List<Board>> getAllBoards() async {
    List<Map<String, dynamic>> boardMaps =
        await _database!.query(Board.tablename);

    List<Board> boards = boardMaps.map((boardMap) {
      int id = boardMap[BoardFields.id];
      String rssData = boardMap[BoardFields.RssData];
      List<int> posts = boardMap[BoardFields.Posts];

      print('Board ID: $id');
      print('Board RssData: $rssData');
      print('Board Posts: $posts');

      return Board.fromJson(boardMap);
    }).toList();

    return boards;
  }
}
