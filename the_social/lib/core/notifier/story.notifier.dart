// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:the_social/core/api/story.api.dart';
import 'package:the_social/core/model/story.model.dart';
import 'package:the_social/core/notifier/authentication.notifier.dart';

import '../../app/credentials/cloundinary.credentials.dart';
import '../../meta/utils/snack_bar.dart';

class StoryNotifier extends ChangeNotifier {
  final StoryAPI storyAPI = StoryAPI();

  File? _storyAssetFile;
  File? get storyAssetFile => _storyAssetFile;
  String? _storyAssetUrl = "";
  String? get storyAssetUrl => _storyAssetUrl;

  Future addStory({
    required BuildContext context,
    required List<String> story_assets,
  }) async {
    try {
      final authenticationNotifier =
          Provider.of<AuthenticationNotifier>(context, listen: false);
      var useremail =
          await authenticationNotifier.fetchUserEmail(context: context);
      var response = await storyAPI.addStory(
          useremail: useremail, story_assets: story_assets);
      print(response);
    } catch (e) {
      print(e.toString());
    }
  }

  Future fetchStories() async {
    try {
      var response = await storyAPI.fetchStories();
      print(response);
    } catch (e) {
      print(e.toString());
    }
  }

  Future showStoryByUser({required BuildContext context}) async {
    try {
      final authenticationNotifier =
          Provider.of<AuthenticationNotifier>(context, listen: false);
      var useremail =
          await authenticationNotifier.fetchUserEmail(context: context);
      var response = await storyAPI.showStoryByUser(useremail: useremail);
      Story modelledData = Story.fromJson(jsonDecode(response));
      List<StoryData> storyData = modelledData.data;
      int code = modelledData.code;
      if (code == 200) {
        return storyData;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future uploadStoryImages({
    required BuildContext context,
  }) async {
    final _cloudinary = Cloudinary.full(
        apiKey: CloudinaryCredentials.APIKEY,
        apiSecret: CloudinaryCredentials.APISecret,
        cloudName: CloudinaryCredentials.CLOUDNAME);

    try {
      await _cloudinary
          .uploadResource(CloudinaryUploadResource(
              filePath: _storyAssetFile!.path,
              resourceType: CloudinaryResourceType.image,
              folder: "theSocial"))
          .then((value) {
        _storyAssetUrl = value.url;
        if (_storyAssetUrl != null) {
          SnackbarUtility.showSnackBar(
              message: "Image uploaded $_storyAssetUrl", context: context);
        }
        notifyListeners();
        return _storyAssetUrl;
      });
    } catch (e) {
      SnackbarUtility.showSnackBar(message: e.toString(), context: context);
    }
  }

  Future<File?> pickStoryAssets() async {
    final _image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (_image != null) {
      _storyAssetFile = File(_image.path);
      notifyListeners();
    }

    return null;
  }

  removeStoryAssets() {
    _storyAssetFile = null;
    notifyListeners();
  }
}
