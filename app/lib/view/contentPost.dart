import 'package:app/model/Board.dart';
import 'package:app/model/Post.dart';
import 'package:app/model/User.dart';
import 'package:app/repo/repository.dart';
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
  final Set<String> favoritedPostIds = <String>{};

  @override
  void initState() {
    super.initState();
    futurePosts = fetchAndParsePosts();
    if (User.instance.favorite != null) {
      for (Post post in User.instance.favorite!) {
        if (post.link != null) {
          favoritedPostIds.add(post.link!);
        }
      }
    }
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
                final post = snapshot.data![index];
                final isFavorited = favoritedPostIds.contains(post.link);
                return ListTile(
                  title: Text(post.title!),
                  subtitle: Text(post.pubDate!),
                  trailing: IconButton(
                    icon: Icon(
                        isFavorited ? Icons.favorite : Icons.favorite_border),
                    onPressed: () {
                      setState(() {
                        if (isFavorited) {
                          favoritedPostIds.remove(post.link);
                          User.instance
                              .removeFavorite(post); // Moved to User class
                        } else {
                          favoritedPostIds.add(post.link!);
                          User.instance
                              .addFavorite(post); // Moved to User class
                        }
                      });
                    },
                  ),
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
    var pubDate = item.findElements('pubDate').first.text;
    var content = item.findElements('description').first.text;

    Post post =
        Post(title: title, link: link, pubDate: pubDate, content: content);
    SqlDatabase.instance.insertPost(post);
    return post;
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
