import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:the_social/app/routes/app.routes.dart';
import 'package:the_social/core/model/post.model.dart';
import 'package:the_social/core/notifier/story.notifier.dart';
import 'package:the_social/core/services/cache.service.dart';
import 'package:the_social/meta/constants/styles.dart';
import 'package:the_social/meta/views/add_post/add_post.views.dart';
import 'package:the_social/meta/views/add_story/add_story.views.dart';
import 'package:the_social/meta/views/feed_view/feed_view.dart';
import 'package:the_social/meta/views/story_list/story_list.view.dart';

import '../../../core/notifier/authentication.notifier.dart';
import '../../../core/notifier/post.notifier.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  final tabs = [
    const FeedView(),
    const AddPostView(),
    const AddStoryView(),
  ];

  @override
  Widget build(BuildContext context) {
    PostNotifier postNotifier(bool renderUi) =>
        Provider.of<PostNotifier>(context, listen: renderUi);
    final CacheService cacheService = CacheService();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: const Text(
          "Your Feed",
          style: textStyleTitle,
        ),
      ),
      bottomNavigationBar: GNav(
        tabs: const [
          GButton(
            icon: Icons.home,
            text: "Home",
          ),
          GButton(
            icon: Icons.add_a_photo,
            text: "Post",
          ),
          GButton(
            icon: Icons.camera,
            text: "Story",
          ),
        ],
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        tabBackgroundColor: Colors.grey.shade800,
        gap: 8,
        onTabChange: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: tabs[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: (() async {
          // final authenticationNotifier =
          //     Provider.of<AuthenticationNotifier>(context, listen: false);
          // var email =
          //     await authenticationNotifier.fetchUserEmail(context: context);
          // print(email);
          // bool i = await cacheService.deleteCache(key: "jwt");
          // print(i);

          // postNotifier(false).fetchPost(context: context);

          // StoryNotifier storyNotifier =
          //     Provider.of<StoryNotifier>(context, listen: false);
          // storyNotifier.showStoryByUser(context: context);

          // Navigator.of(context).pushNamed(AddStoryRoute);
        }),
      ),
    );
  }
}
