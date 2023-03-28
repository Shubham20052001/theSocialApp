import 'dart:io';

import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:the_social/app/credentials/cloundinary.credentials.dart';
import 'package:the_social/meta/utils/pick_image.util.dart';
import 'package:the_social/meta/utils/snack_bar.dart';

class UtilityNotifier extends ChangeNotifier {
  String? _userimage = "";
  String? get userimage => _userimage;

  Future uploadUserImage({
    required BuildContext context,
  }) async {
    final _cloudinary = Cloudinary.full(
        apiKey: CloudinaryCredentials.APIKEY,
        apiSecret: CloudinaryCredentials.APISecret,
        cloudName: CloudinaryCredentials.CLOUDNAME);

    try {
      final _image = await ImageUtility.getImage();
      await _cloudinary
          .uploadResource(CloudinaryUploadResource(
              filePath: _image!.path,
              resourceType: CloudinaryResourceType.image,
              folder: "theSocial"))
          .then((value) {
        _userimage = value.url;
        notifyListeners();
        return _userimage;
      });
    } catch (e) {
      SnackbarUtility.showSnackBar(message: e.toString(), context: context);
    }
  }
}
