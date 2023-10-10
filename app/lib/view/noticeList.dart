import 'package:app/model/Board.dart';
import 'package:app/model/User.dart';
import 'package:app/repo/repository.dart';
import 'package:app/view/contentPost.dart';
import 'package:flutter/material.dart';

class NoticeList extends StatefulWidget {
  const NoticeList({super.key});

  @override
  State<NoticeList> createState() => _NoticeListState();
}

class _NoticeListState extends State<NoticeList> {
  List<int?>? boards;

  @override
  void initState() {
    super.initState();
    _loadBoardByUser();
  }

  _loadBoardByUser() async {
    if (User.instance.department == null ||
        User.instance.department!.Boards == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("알림"),
              content: const Text("학과를 설정해 주세요"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("확인"),
                ),
              ],
            );
          },
        );
      });
    } else {
      boards = User.instance.department!.Boards;
    }
    setState(() {});
  }

  Future<Board?> _getBoard(int? boardId) async {
    return await SqlDatabase.instance.getBoardById(boardId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('게시판 목록'),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (User.instance.department != null &&
                    User.instance.department!.Boards != null)
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: User.instance.department!.Boards!.length,
                    itemBuilder: (context, index) {
                      return FutureBuilder<Board?>(
                        future: _getBoard(boards![index]),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (snapshot.hasData) {
                              Board? board = snapshot.data;
                              return ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            contentPost(board: board)),
                                  );
                                },
                                child: Text(board!.name!), // 게시판 이름으로 버튼 텍스트 설정
                              );
                            }
                          }
                          return const CircularProgressIndicator(); // Show loading indicator while fetching data
                        },
                      );
                    },
                  ),
              ],
            ),
          ]),
        ));
  }
}
