import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class RssDatabase {
  //SQLite 데이터베이스 인스턴스에 대한 참조를 저장하는 변수다.
  Database? _database;

  //데이터베이스 인스턴스를 가져오는 비동기 메세드이다.
  //인스턴스가 이미 초기화되었다면 그냥 반환하고 아닐경우 db를 초기화하여 반환한다.
  Future<Database> get database async {
    if (_database != null) return _database!;

    return await initDB();
  }

  //데이터베이스 파일 경로를 생성한다.
  initDB() async {
    //데이터베이스 파일이 저장될 경로를 반환한다.
    String path = join(await getDatabasesPath(), 'depart_rss.db');
    //데이터베이스 파일을 열고 생성한다.
    return await openDatabase(
      path,
      //데이터베이스 스키마 버전을 나타낸다
      version: 1,
      //데이터베이스 생성 시 호출될 콜백 함수이다.
      onCreate: _onCreate,
      //데이터베이스 업그레이드 콜백 함수이다.
    );
  }

  //데이터베이스 테이블을 생성하는 콜백 함수이다.
  //'RssData' 테이블을 생성하고 열 칼럼들을 정의한다.
  FutureOr<void> _onCreate(Database db, int version) {
    String sql = '''
    CREATE TABLE RssData(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      department TEXT NOT NULL,
      noticeMenu TEXT NOT NULL,
      Rss TEXT NOT NULL)
    ''';
    //SQL 쿼리를 실행하여 테이블을 생성한다.
    db.execute(sql);
  }
}
