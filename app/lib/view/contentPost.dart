import 'package:flutter/material.dart';

class contentPost extends StatefulWidget {
  const contentPost({super.key});

  @override
  State<contentPost> createState() => _contentPostState();
}

class _contentPostState extends State<contentPost> {
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
      body: const Text("임시"),
    );
  }
}
