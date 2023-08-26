// import 'dart:convert';
// import 'package:app/model/Board.dart';
// import 'package:app/repo/repository.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   SqlDatabase();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   List<Board> boards = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchBoardsFromJsonAsset().then((parsedBoards) {
//       setState(() {
//         boards = parsedBoards;
//       });
//     });
//   }

//   Future<List<Board>> fetchBoardsFromJsonAsset() async {
//     final String response =
//         await rootBundle.loadString('assets/json/Boards.json');
//     final Map<String, dynamic> jsonData = json.decode(response);

//     List<Board> parsedBoards = [];
//     for (String category in jsonData.keys) {
//       print("Current Category: $category");
//       for (var boardData in jsonData[category]) {
//         Board board = Board.fromJson(boardData);
//         await SqlDatabase.instance
//             .insertBoard(board); // Wait for the insertion to complete
//         parsedBoards.add(board);
//       }
//     }

//     return parsedBoards;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Board List'),
//       ),
//       body: ListView.builder(
//         itemCount: boards.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(boards[index].name!),
//             subtitle: Text(boards[index].RssData!),
//           );
//         },
//       ),
//     );
//   }
// }
