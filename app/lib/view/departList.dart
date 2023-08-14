import 'package:flutter/material.dart';

class departList extends StatefulWidget {
  const departList({super.key});

  @override
  State<departList> createState() => _departListState();
}

class _departListState extends State<departList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('과설정하기'),
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
