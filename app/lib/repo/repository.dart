import 'package:app/model/Board.dart';
import 'package:app/model/Department.dart';
import 'package:app/model/Post.dart';
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

  Future<void> initDB() async {
    await _initDataBase();
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
      ${PostFields.link} TEXT not null,
      ${PostFields.pubDate} TEXT not null,
      ${PostFields.content} TEXT not null,
      UNIQUE(${PostFields.title}, ${PostFields.link},${PostFields.content})
    )
  ''');
  }

  Future<int> insertPost(Post post) async {
    print(post.id);
    return await _database!.insert(
      Post.tablename,
      post.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
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

  Future<void> deleteAllPosts() async {
    await _database!.delete(Post.tablename);
  }

  Future<void> deleteAllDepartments() async {
    await _database!.delete(Department.tablename);
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

  Future<List<Department>> getAllDepartments() async {
    List<Map<String, dynamic>> departmentMaps =
        await _database!.query(Department.tablename);

    List<Department> departments = departmentMaps.map((departmentMap) {
      int id = departmentMap[DepartmentFields.id];
      String major = departmentMap[DepartmentFields.major];
      List<int> boards = departmentMap[DepartmentFields.Boards];

      print('Department ID: $id');
      print('Department Major: $major');
      print('Department Boards: $boards');

      return Department.fromJson(departmentMap);
    }).toList();

    return departments;
  }

  Future<Board?> getBoardById(int? boardId) async {
    List<Map<String, dynamic>> boardMaps = await _database!.query(
      Board.tablename,
      where: '${BoardFields.id} = ?',
      whereArgs: [boardId],
    );

    if (boardMaps.isNotEmpty) {
      Map<String, dynamic> boardMap = boardMaps.first;
      int id = boardMap[BoardFields.id];
      String RssData = boardMap[BoardFields.RssData];
      String name = boardMap[BoardFields.name];
      List<int> posts = boardMap[BoardFields.Posts];

      print('Board ID: $id');
      print('Board RssData: $RssData');
      print('Board Name: $name');
      print('Board Posts: $posts');

      return Board(
        id: id,
        RssData: RssData,
        name: name,
        Posts: posts,
      );
    }

    return null; // Return null if no board found with the specified id
  }

  Future<Post?> getPostById(int? postId) async {
    List<Map<String, dynamic>> PostMaps = await _database!.query(
      Post.tablename,
      where: '${PostFields.id} = ?',
      whereArgs: [postId],
    );

    if (PostMaps.isNotEmpty) {
      Map<String, dynamic> PostMap = PostMaps.first;
      int id = PostMap[PostFields.id];
      String title = PostMap[PostFields.title];
      String link = PostMap[PostFields.link];
      String pubDate = PostMap[PostFields.pubDate];
      String content = PostMap[PostFields.content];

      print("Post Mapping");

      return Post(
          id: id, title: title, link: link, pubDate: pubDate, content: content);
    }

    return null;
  }

  Future<void> updateBoard(Board board) async {
    await _database!.update(
      Board.tablename,
      board.toJson(),
      where: '${BoardFields.id} = ?',
      whereArgs: [board.id],
    );
  }
}
