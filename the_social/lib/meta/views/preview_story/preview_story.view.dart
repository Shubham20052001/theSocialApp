import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../core/model/story.model.dart';
import '../../../core/notifier/story.notifier.dart';

class PreviewMyStoryView extends StatefulWidget {
  const PreviewMyStoryView({super.key});

  @override
  State<PreviewMyStoryView> createState() => _PreviewMyStoryViewState();
}

class _PreviewMyStoryViewState extends State<PreviewMyStoryView> {
  @override
  Widget build(BuildContext context) {
    StoryNotifier storyNotifier(bool renderUi) =>
        Provider.of<StoryNotifier>(context, listen: renderUi);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: FutureBuilder(
          future: storyNotifier(false).showStoryByUser(context: context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              List<StoryData> storyData = snapshot.data;
              return ListView.builder(
                itemCount: storyData.length,
                itemBuilder: (context, index) {
                  return PreviewStoryBlock(storyData: storyData[index]);
                },
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class PreviewStoryBlock extends StatelessWidget {
  final StoryData storyData;
  const PreviewStoryBlock({super.key, required this.storyData});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const SizedBox(
            width: 20,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(storyData.storyUser.userimage),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  Text(storyData.storyUser.username),
                  Text(timeago.format(storyData.storyTime)),
                ],
              )
            ],
          ),
          Container(
            height: 600,
            child: Image.network(
              storyData.storyAssets[0],
              fit: BoxFit.fitWidth,
            ),
          )
        ],
      ),
    );
  }
}
