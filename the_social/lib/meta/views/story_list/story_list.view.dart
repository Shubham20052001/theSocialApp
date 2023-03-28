import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_social/app/routes/app.routes.dart';
import 'package:the_social/core/api/authentication.api.dart';

import '../../../core/notifier/authentication.notifier.dart';
import '../../../core/notifier/story.notifier.dart';

class StoryListView extends StatefulWidget {
  const StoryListView({super.key});

  @override
  State<StoryListView> createState() => _StoryListViewState();
}

class _StoryListViewState extends State<StoryListView> {
  @override
  Widget build(BuildContext context) {
    StoryNotifier storyNotifier(bool renderUi) =>
        Provider.of<StoryNotifier>(context, listen: renderUi);

    final AuthenticationAPI _authenticationAPI = AuthenticationAPI();

    return Container(
      height: 60,
      child: Row(
        children: [
          FutureBuilder(
            future: _authenticationAPI.getUserData(context: context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                var body = jsonDecode(snapshot.data);
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(PreviewStoryRoute);
                  },
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.blueAccent,
                    backgroundImage: NetworkImage(body['userimage']),
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
