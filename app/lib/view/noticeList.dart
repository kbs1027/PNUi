import 'dart:convert';

import 'package:app/model/Board.dart';
import 'package:app/model/Department.dart';
import 'package:app/repo/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NoticeList extends StatefulWidget {
  const NoticeList({super.key});

  @override
  State<NoticeList> createState() => _NoticeListState();
}

class _NoticeListState extends State<NoticeList> {
  List<Board> boards = [];
  List<int?> boardIds = [];

  @override
  void initState() {
    super.initState();
    fetchBoardsFromJsonAsset().then((parsedBoards) {
      setState(() {
        boards = parsedBoards;
      });
    });
  }

  Future<List<Board>> fetchBoardsFromJsonAsset() async {
    SqlDatabase.instance.deleteAllBoards();
    final String boardData =
        await rootBundle.loadString('assets/json/Boards.json');
    final String departmentData =
        await rootBundle.loadString('assets/json/Departments.json');
    final Map<String, dynamic> jsonBoardData = json.decode(boardData);
    final Map<String, dynamic> jsonDepartmentData = json.decode(departmentData);

    List<Board> parsedBoards = [];
    for (String category in jsonBoardData.keys) {
      boardIds.clear();
      print("Current Category: $category");
      Department department = Department.fromJson(jsonDepartmentData[category]);
      for (var boardData in jsonBoardData[category]) {
        Board board = Board.fromJson(boardData);
        int? insertedBoardId = await SqlDatabase.instance.insertBoard(board);
        print(await SqlDatabase.instance
            .getAllBoards()); // Wait for the insertion to complete
        parsedBoards.add(board);
        boardIds.add(insertedBoardId);
        print(boardIds);
      }
      department.UpdateBoards(boardIds);
      print("department.Boards = ${department.Boards}");
      SqlDatabase.instance.insertDepartment(department);
      // Department department = Department.fromJson(jsonDepartmentData[category]);
      // print(department);
      // print(department.Boards);
      // print(department.id);
      // print(boardIds);
      // department.Boards = boardIds;
      // SqlDatabase.instance.insertDepartment(department);
    }

    return parsedBoards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Board List'),
      ),
      body: ListView.builder(
        itemCount: boards.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(boards[index].name!),
            subtitle: Text(boards[index].RssData!),
          );
        },
      ),
    );
  }
}
