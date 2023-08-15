import 'package:app/model/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:app/repo/repository.dart';

Future<void> insertRss(RssData rssData) async {
  final db = await RssDatabase().database;
  await db.insert('RssData', rssData.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<List<RssData>> getAllRss() async {
  final db = await RssDatabase().database;
  final List<Map<String, dynamic>> maps = await db.query('RssData');

  return List.generate(maps.length, (i) => RssData.fromMap(maps[i]));
}

Future<void> updateRss(RssData rssData) async {
  final db = await RssDatabase().database;
  await db.update('RssData', rssData.toMap(),
      where: 'id = ?', whereArgs: [rssData.id]);
}

Future<void> deleteRss(int id) async {
  final db = await RssDatabase().database;
  await db.delete('RssData', where: 'id = ?', whereArgs: [id]);
}

// department 기준으로 RssData를 가져옵니다.
Future<RssData?> getRssByDepartment(String department) async {
  final db = await RssDatabase().database;
  List<Map<String, dynamic>> maps = await db
      .query('RssData', where: 'department = ?', whereArgs: [department]);

  if (maps.isNotEmpty) {
    return RssData.fromMap(maps.first);
  }
  return null;
}

// department 기준으로 모든 RssData를 가져옵니다.
Future<List<RssData>> getAllRssByDepartment(String department) async {
  final db = await RssDatabase().database;
  final List<Map<String, dynamic>> maps = await db
      .query('RssData', where: 'department = ?', whereArgs: [department]);

  return List.generate(maps.length, (i) => RssData.fromMap(maps[i]));
}

// department 기준으로 RssData를 업데이트합니다.
Future<void> updateRssByDepartment(RssData rssData) async {
  final db = await RssDatabase().database;
  await db.update('RssData', rssData.toMap(),
      where: 'department = ?', whereArgs: [rssData.department]);
}

// department 기준으로 RssData를 삭제합니다.
Future<void> deleteRssByDepartment(String department) async {
  final db = await RssDatabase().database;
  await db.delete('RssData', where: 'department = ?', whereArgs: [department]);
}
