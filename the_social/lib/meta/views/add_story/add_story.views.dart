import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_social/core/notifier/story.notifier.dart';

class AddStoryView extends StatefulWidget {
  const AddStoryView({super.key});

  @override
  State<AddStoryView> createState() => _AddStoryViewState();
}

class _AddStoryViewState extends State<AddStoryView> {
  StoryNotifier storyNotifier(bool renderUi) =>
      Provider.of<StoryNotifier>(context, listen: renderUi);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Story"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (storyNotifier(true).storyAssetFile != null)
                Container(
                  child: Image.file(storyNotifier(false).storyAssetFile!),
                ),
              if (storyNotifier(true).storyAssetFile == null)
                ElevatedButton(
                  onPressed: () {
                    storyNotifier(false).pickStoryAssets();
                  },
                  child: const Text("Add story"),
                ),
              if (storyNotifier(true).storyAssetFile != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        storyNotifier(false).pickStoryAssets();
                      },
                      child: const Text("Reselect story"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        storyNotifier(false).removeStoryAssets();
                      },
                      child: const Text("Remove story"),
                    ),
                  ],
                ),
              if (storyNotifier(true).storyAssetFile != null)
                ElevatedButton(
                  onPressed: () async {
                    await storyNotifier(false)
                        .uploadStoryImages(context: context)
                        .whenComplete(() async {
                      if (storyNotifier(false).storyAssetUrl != null) {
                        await storyNotifier(false).addStory(
                            context: context,
                            story_assets: [
                              storyNotifier(false).storyAssetUrl!
                            ]);
                      }
                    });
                  },
                  child: const Text("Upload story"),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
