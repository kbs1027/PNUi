import 'package:app/view/departList.dart';
import 'package:app/view/interest.dart';
import 'package:app/view/noticeList.dart';
import 'package:app/view/noticeListWidget.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const departList()),
                );
              },
              child: const Text('학과설정'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NoticeList()),
                );
              },
              child: const Text('공지사항'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const interest()),
                );
              },
              child: const Text('관심목록'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const noticeListWidget()),
                );
              },
              child: const Text('알림설정'),
            ),
          ],
        ),
      ),
    );
  }
}
