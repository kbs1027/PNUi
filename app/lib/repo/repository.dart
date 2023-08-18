import 'package:app/model/Board.dart';
import 'package:app/model/Department.dart';
import 'package:app/model/Post.dart';
import 'package:app/model/User.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDatabase {
  static final SqlDatabase instance = SqlDatabase._instance();

  Database? _database;

  SqlDatabase._instance() {
    _initDataBase();
  }

  factory SqlDatabase() {
    return instance;
  }

  Future<void> _initDataBase() async {
    var dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, 'pnu.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${Department.tablename} (
        ${DepartmentFields.id} integer primary key autoincrement,
        ${DepartmentFields.major} TEXT,
        ${DepartmentFields.Boards} INTEGER, FOREIGN KEY(${DepartmentFields.Boards}) REFERENCES Boards(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE ${Board.tablename} (
        ${BoardFields.id} integer primary key autoincrement,
        ${BoardFields.RssData} TEXT,
        ${BoardFields.name} TEXT,
        ${BoardFields.Posts} INTEGER, FOREIGN KEY(${BoardFields.Posts}) REFERENCES Posts(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE ${Post.tablename} (
        ${PostFields.id} integer primary key autoincrement,
        ${PostFields.title} TEXT,
        ${PostFields.content} TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE ${User.tablename} (
        ${UserFields.id} integer primary key autoincrement,
        ${UserFields.department} INTEGER, FOREIGN KEY(${UserFields.department}) REFERENCES Departments(id),
        ${UserFields.subscribe} INTEGER, FOREIGN KEY(${UserFields.subscribe}) REFERENCES Boards(id),
        ${UserFields.favorite} INTEGER, FOREIGN KEY(${UserFields.favorite}) REFERENCES Posts(id)
      )
    ''');
  }
}
