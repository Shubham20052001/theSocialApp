import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_social/core/dto/post.dto.dart';
import 'package:the_social/core/notifier/post.notifier.dart';
import 'package:the_social/core/notifier/utility.notifier.dart';
import 'package:the_social/meta/utils/snack_bar.dart';

import '../../../core/notifier/authentication.notifier.dart';

class AddPostView extends StatefulWidget {
  const AddPostView({super.key});

  @override
  State<AddPostView> createState() => _AddPostViewState();
}

class _AddPostViewState extends State<AddPostView> {
  TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    titleController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PostNotifier postNotifier(bool renderUi) =>
        Provider.of<PostNotifier>(context, listen: renderUi);
    // final authenticationNotifier =
    //     Provider.of<AuthenticationNotifier>(context, listen: true);
    // var useremail = authenticationNotifier.fetchUserEmail(context: context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text("Add Post")),
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: "Enter title..."),
          ),
          postNotifier(true).selectedPostImage != null
              ? Container(
                  height: 400,
                  width: 400,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: FileImage(
                              postNotifier(true).selectedPostImage!))),
                )
              : const SizedBox(
                  height: 0,
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    postNotifier(false).pickPostImage();
                  },
                  child: Text(postNotifier(true).selectedPostImage == null
                      ? "Select image"
                      : "Reselect image")),
              if (postNotifier(true).selectedPostImage != null)
                ElevatedButton(
                    onPressed: () {
                      postNotifier(false).removeImages();
                    },
                    child: const Text("Remove image")),
            ],
          ),
          ElevatedButton(
              onPressed: () async {
                final authenticationNotifier =
                    Provider.of<AuthenticationNotifier>(context, listen: false);
                var useremail = await authenticationNotifier.fetchUserEmail(
                    context: context);
                var post_image = postNotifier(false).uploadedImageUrl;
                var post_title = titleController.text;

                await postNotifier(false).uploadUserImage(context: context);

                if (post_image != null) {
                  await postNotifier(false)
                      .addPost(
                    context: context,
                    postDTO: PostDTO(
                        post_title: post_title,
                        post_images: post_image,
                        useremail: useremail),
                  )
                      .whenComplete(() {
                    SnackbarUtility.showSnackBar(
                        message: "Post added in database", context: context);
                  });
                } else {
                  SnackbarUtility.showSnackBar(
                      message: "Image not uploaded", context: context);
                }
              },
              child: const Text("Post")),
        ],
      )),
    );
  }
}
