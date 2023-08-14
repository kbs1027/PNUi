import 'package:flutter/material.dart';

class interest extends StatefulWidget {
  const interest({super.key});

  @override
  State<interest> createState() => _interestState();
}

class _interestState extends State<interest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('관심목록'),
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
