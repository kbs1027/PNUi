import 'package:app/repo/repository.dart';
import 'package:app/service/InsertBoard.dart';
import 'package:app/view/home.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SqlDatabase.instance.initDB();
  await fetchBoardsFromJsonAsset();
  runApp(const Landing());
}

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: home(),
      ),
    );
  }
}
