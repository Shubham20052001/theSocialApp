import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/model/post.model.dart';
import '../../../core/notifier/post.notifier.dart';
import '../story_list/story_list.view.dart';

class FeedView extends StatefulWidget {
  const FeedView({super.key});

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  @override
  Widget build(BuildContext context) {
    PostNotifier postNotifier(bool renderUi) =>
        Provider.of<PostNotifier>(context, listen: renderUi);
    return Column(
      children: [
        // const StoryListView(),
        Container(
          height: 570,
          child: FutureBuilder(
            future: postNotifier(false).fetchPost(context: context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                var _snapshot = snapshot.data as List;
                return ListOfPosts(snapshot: _snapshot);
              }
            },
          ),
        ),
      ],
    );
  }
}

class ListOfPosts extends StatelessWidget {
  final dynamic snapshot;
  const ListOfPosts({super.key, required this.snapshot});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: snapshot.length,
      itemBuilder: (context, index) {
        PostData postData = snapshot[index];
        return ListTile(
          leading: CircleAvatar(
              backgroundImage: NetworkImage(postData.postImages[0])),
          title: Text(postData.postTitle),
        );
      },
    );
  }
}
