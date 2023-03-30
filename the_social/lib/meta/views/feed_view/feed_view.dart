import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_social/meta/constants/styles.dart';

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
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "${postData.postUser.username} posted: ",
                    style: textStyle1,
                  ),
                  Text(
                    postData.postTitle,
                    style: textStyle1.copyWith(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              sBox10,
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  postData.postImages[0],
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
