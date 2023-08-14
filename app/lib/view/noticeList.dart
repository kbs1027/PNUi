import 'package:flutter/material.dart';

class noticeList extends StatefulWidget {
  const noticeList({super.key});

  @override
  State<noticeList> createState() => _noticeListState();
}

class _noticeListState extends State<noticeList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('게시판목록'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
    );
  }
}
