import 'package:app/model/Post.dart';
import 'package:app/model/User.dart';
import 'package:app/view/Webview.dart';
import 'package:flutter/material.dart';

class interest extends StatefulWidget {
  const interest({super.key});

  @override
  State<interest> createState() => _interestState();
}

class _interestState extends State<interest> {
  List<Post>? favorites = User.instance.favorite;
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
      body: favorites == null || favorites!.isEmpty
          ? const Center(child: Text('No favorites added yet.'))
          : ListView.builder(
              itemCount: favorites!.length,
              itemBuilder: (context, index) {
                Post post = favorites![index];
                return ListTile(
                  title: Text(post.title ?? ""),
                  subtitle: Text(post.content ?? ""),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        User.instance.removeFavorite(post);
                      });
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => map(url: post.link!),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
