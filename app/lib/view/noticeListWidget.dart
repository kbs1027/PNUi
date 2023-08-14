import 'package:flutter/material.dart';

class noticeListWidget extends StatefulWidget {
  const noticeListWidget({super.key});

  @override
  State<noticeListWidget> createState() => _noticeListWidgetState();
}

class _noticeListWidgetState extends State<noticeListWidget> {
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
