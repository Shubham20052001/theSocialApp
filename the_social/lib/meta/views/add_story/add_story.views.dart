import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_social/core/notifier/story.notifier.dart';
import 'package:the_social/meta/constants/styles.dart';

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
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (storyNotifier(true).storyAssetFile != null)
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Image.file(storyNotifier(false).storyAssetFile!),
              ),
            sBox10,
            if (storyNotifier(true).storyAssetFile == null)
              button1(
                onPress: () {
                  storyNotifier(false).pickStoryAssets();
                },
                text: "Add story",
              ),
            if (storyNotifier(true).storyAssetFile != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  button1(
                    onPress: () {
                      storyNotifier(false).pickStoryAssets();
                    },
                    text: "Reselect image",
                  ),
                  button1(
                    onPress: () {
                      storyNotifier(false).removeStoryAssets();
                    },
                    text: "Remove image",
                  ),
                ],
              ),
            sBox10,
            if (storyNotifier(true).storyAssetFile != null)
              button1(
                onPress: () async {
                  await storyNotifier(false)
                      .uploadStoryImages(context: context)
                      .whenComplete(() async {
                    if (storyNotifier(false).storyAssetUrl != null) {
                      await storyNotifier(false).addStory(
                          context: context,
                          story_assets: [storyNotifier(false).storyAssetUrl!]);
                    }
                  });
                },
                text: "Upload story",
              ),
          ],
        ),
      ),
    );
  }
}
