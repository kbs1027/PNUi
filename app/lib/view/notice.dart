import 'package:flutter/material.dart';

class notice extends StatefulWidget {
  const notice({super.key});

  @override
  State<notice> createState() => _noticeState();
}

class _noticeState extends State<notice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('공지'),
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
