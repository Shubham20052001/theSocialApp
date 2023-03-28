import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:the_social/app/routes/api.routes.dart';
import 'package:the_social/core/dto/post.dto.dart';

class StoryAPI {
  final client = http.Client();
  final headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Access-Control-Allow-Origin': '*',
  };

  //! Create new Post
  Future addStory(
      {required String useremail, required List<String> story_assets}) async {
    try {
      String subUrl = "/story/add/$useremail";
      final Uri uri = Uri.parse(APIRoutes.BaseURL + subUrl);
      final http.Response response = await client.post(
        uri,
        body: jsonEncode({"story_assets": story_assets}),
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

  //! Fetch Stories
  Future fetchStories() async {
    try {
      String subUrl = "/story/";
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

  //! Delete Story
  Future deleteStory({required dynamic story_id}) async {
    final String subUrl = "/story/delete/$story_id";
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
  Future showStoryByUser({required String useremail}) async {
    final String subUrl = "/story/user/$useremail";
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

  //! Render Story Of Others
  Future showStoryOfOtherPeople({required String useremail}) async {
    final String subUrl = "/story/other/$useremail";
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
