import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:the_social/core/api/post.api.dart';
import 'package:the_social/core/model/post.model.dart';
import 'package:the_social/core/notifier/authentication.notifier.dart';

import '../../app/credentials/cloundinary.credentials.dart';
import '../../meta/utils/pick_image.util.dart';
import '../../meta/utils/snack_bar.dart';
import '../dto/post.dto.dart';

class PostNotifier extends ChangeNotifier {
  final PostAPI _postAPI = PostAPI();
  File? _selectedPostImage;
  File? get selectedPostImage => _selectedPostImage;

  String? _uploadedImageUrl;
  String? get uploadedImageUrl => _uploadedImageUrl;

  Future addPost({
    required BuildContext context,
    required PostDTO postDTO,
  }) async {
    try {
      await _postAPI.addPost(postDTO);
    } catch (e) {
      print(e.toString());
    }
  }

  Future fetchPost({
    required BuildContext context,
  }) async {
    try {
      var response = await _postAPI.fetchPost();
      var modelledData = Post.fromJson(jsonDecode(response));
      var postCode = modelledData.code;
      var postData = modelledData.data;
      var isPostReceived = modelledData.received;
      switch (postCode) {
        case 200:
          {
            // print(postData);
            return postData;
          }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future uploadUserImage({
    required BuildContext context,
  }) async {
    final _cloudinary = Cloudinary.full(
        apiKey: CloudinaryCredentials.APIKEY,
        apiSecret: CloudinaryCredentials.APISecret,
        cloudName: CloudinaryCredentials.CLOUDNAME);

    try {
      await _cloudinary
          .uploadResource(CloudinaryUploadResource(
              filePath: _selectedPostImage!.path,
              resourceType: CloudinaryResourceType.image,
              folder: "theSocial"))
          .then((value) {
        _uploadedImageUrl = value.url;
        if (_uploadedImageUrl != null) {
          SnackbarUtility.showSnackBar(
              message: "Image uploaded $_uploadedImageUrl", context: context);
        }
        notifyListeners();
        return _uploadedImageUrl;
      });
    } catch (e) {
      SnackbarUtility.showSnackBar(message: e.toString(), context: context);
    }
  }

  Future<File?> pickPostImage() async {
    final _image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (_image != null) {
      _selectedPostImage = File(_image.path);
      notifyListeners();
    }

    return null;
  }

  removeImages() {
    _selectedPostImage = null;
    notifyListeners();
  }
}
