import 'package:app/model/Post.dart';
import 'package:xml/xml.dart';
import 'package:http/http.dart' as http;

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

void main() async {
  var rssUrl = 'https://cse.pusan.ac.kr/bbs/cse/12278/rssList.do?row=50';
  String rssData = await fetchRssData(rssUrl);
  List<Post> posts = parseRssToPosts(rssData);

  for (var post in posts) {
    print(post.toJson());
  }
}
