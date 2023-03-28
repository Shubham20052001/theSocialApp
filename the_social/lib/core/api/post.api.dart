import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:the_social/app/routes/api.routes.dart';
import 'package:the_social/core/dto/post.dto.dart';

class PostAPI {
  final client = http.Client();
  final headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Access-Control-Allow-Origin': '*',
  };

  //! Create new Post
  Future addPost(PostDTO postDTO) async {
    try {
      String subUrl = "/post/add/${postDTO.useremail}";
      final Uri uri = Uri.parse(APIRoutes.BaseURL + subUrl);
      final http.Response response = await client.post(
        uri,
        body: jsonEncode(postDTO.toJson()),
        headers: headers,
      );

      final statusCode = response.statusCode;
      final body = response.body;

      if (statusCode == 200) {
        return body;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //! Fetch Post
  Future fetchPost() async {
    try {
      String subUrl = "/post/";
      final Uri uri = Uri.parse(APIRoutes.BaseURL + subUrl);
      final http.Response response = await client.get(
        uri,
        headers: headers,
      );

      final statusCode = response.statusCode;
      final body = response.body;

      if (statusCode == 200) {
        return body;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //! Delete Post
  Future deletePost({required dynamic post_id}) async {
    final String subUrl = "/post/delete/$post_id";
    final Uri uri = Uri.parse(APIRoutes.BaseURL + subUrl);
    try {
      final http.Response response = await client.delete(uri, headers: headers);
      final statusCode = response.statusCode;
      final body = response.body;
      if (statusCode == 200) {
        // print(body);
        return body;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //! Render solo Post
  Future showSoloPost({required dynamic post_id}) async {
    final String subUrl = "/post/details/$post_id";
    final Uri uri = Uri.parse(APIRoutes.BaseURL + subUrl);
    try {
      final http.Response response = await client.get(uri, headers: headers);
      final statusCode = response.statusCode;
      final body = response.body;
      if (statusCode == 200) {
        // print(body);
        return body;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
