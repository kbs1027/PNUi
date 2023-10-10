// import 'package:app/model/Board.dart';
// import 'package:app/model/Post.dart';
// import 'package:app/repo/repository.dart';
// import 'package:http/http.dart' as http;
// import 'package:xml/xml.dart';

// Future<void> fetchAndPopulatePostsFromRss(int boardId, String? rssUrl) async {
//   // Fetch RSS data
//   final response = await http.get(Uri.parse(rssUrl!));

//   if (response.statusCode == 200) {
//     // Parse the RSS data
//     final document = XmlDocument.parse(response.body);
//     final items = document.findAllElements("item");

//     List<int> postIds = [];

//     for (var item in items) {
//       final title = item.findElements("title").first.text;
//       final link = item.findElements("link").first.text;
//       final description = item.findElements("description").first.text;

//       // Create Post object
//       Post newPost = Post(title: title, link: link, content: description);

//       // Insert Post into database and get its id
//       int? postId = await SqlDatabase.instance.insertPost(newPost);
//       postIds.add(postId);
//     }

//     // Update the board's Posts list
//     Board? board = await SqlDatabase.instance.getBoardById(boardId);
//     if (board != null) {
//       board.updatePosts(postIds);

//       // Update the board in the database
//       await SqlDatabase.instance.updateBoard(board);
//     }
//   } else {
//     print("Failed to load RSS data");
//   }
// }

// Future<void> backgroundTask() async {
//   // Fetch all boards
//   List<Board> allBoards = await SqlDatabase.instance.getAllBoards();

//   for (Board board in allBoards) {
//     fetchAndPopulatePostsFromRss(board.id!, board.RssData);
//   }
// }
