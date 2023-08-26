import 'package:app/model/Board.dart';
import 'package:app/model/Post.dart';
import 'package:app/view/Webview.dart';
import 'package:xml/xml.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class contentPost extends StatefulWidget {
  final Board? board;

  const contentPost({Key? key, required this.board}) : super(key: key);

  @override
  State<contentPost> createState() => _contentPostState();
}

class _contentPostState extends State<contentPost> {
  late Future<List<Post>> futurePosts;

  @override
  void initState() {
    super.initState();
    futurePosts = fetchAndParsePosts();
  }

  Future<List<Post>> fetchAndParsePosts() async {
    String rssUrl = widget.board?.RssData ?? "";
    String rssData = await fetchRssData(rssUrl);
    return parseRssToPosts(rssData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.board?.name ?? ""),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: FutureBuilder<List<Post>>(
        future: futurePosts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].title!),
                  subtitle: Text(snapshot.data![index].content!),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              map(url: snapshot.data![index].link!)),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

List<Post> parseRssToPosts(String rssData) {
  var document = XmlDocument.parse(rssData);
  var items = document.findAllElements('item');

  return items.map((item) {
    var title = item.findElements('title').first.text;
    var link = item.findElements('link').first.text;
    var content = item.findElements('description').first.text;

    return Post(title: title, link: link, content: content);
  }).toList();
}

Future<String> fetchRssData(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to load RSS data');
  }
}
