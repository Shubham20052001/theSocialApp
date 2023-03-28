import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_social/app/routes/app.routes.dart';
import 'package:the_social/core/model/post.model.dart';
import 'package:the_social/core/notifier/story.notifier.dart';
import 'package:the_social/core/services/cache.service.dart';
import 'package:the_social/meta/views/story_list/story_list.view.dart';

import '../../../core/notifier/post.notifier.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    PostNotifier postNotifier(bool renderUi) =>
        Provider.of<PostNotifier>(context, listen: renderUi);
    final CacheService cacheService = CacheService();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home View"),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (() async {
        // final authenticationNotifier =
        //     Provider.of<AuthenticationNotifier>(context, listen: false);
        // var email =
        //     await authenticationNotifier.fetchUserEmail(context: context);
        // print(email);
        // var i = await cacheService.deleteCache(key: "jwt");
        // print(i);

        // postNotifier(false).fetchPost(context: context);

        StoryNotifier storyNotifier =
            Provider.of<StoryNotifier>(context, listen: false);
        storyNotifier.showStoryByUser(context: context);

        Navigator.of(context).pushNamed(AddStoryRoute);
      })),
      body: Column(
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
      ),
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
