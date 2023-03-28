// To parse this JSON data, do
//
//     final story = storyFromJson(jsonString);

import 'dart:convert';

Story storyFromJson(String str) => Story.fromJson(json.decode(str));

String storyToJson(Story data) => json.encode(data.toJson());

class Story {
  Story(
    this.code,
    this.data,
  );

  int code;
  List<StoryData> data;

  factory Story.fromJson(Map<String, dynamic> json) => Story(
        json["code"],
        List<StoryData>.from(json["data"].map((x) => StoryData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class StoryData {
  StoryData(
    this.storyId,
    this.storyAssets,
    this.storyTime,
    this.storyUser,
  );

  int storyId;
  List<String> storyAssets;
  DateTime storyTime;
  StoryUser storyUser;

  factory StoryData.fromJson(Map<String, dynamic> json) => StoryData(
        json["story_id"],
        List<String>.from(json["story_assets"].map((x) => x)),
        DateTime.parse(json["story_time"]),
        StoryUser.fromJson(json["story_user"]),
      );

  Map<String, dynamic> toJson() => {
        "story_id": storyId,
        "story_assets": List<dynamic>.from(storyAssets.map((x) => x)),
        "story_time": storyTime.toIso8601String(),
        "story_user": storyUser.toJson(),
      };
}

class StoryUser {
  StoryUser(
    this.id,
    this.username,
    this.useremail,
    this.userpassword,
    this.userimage,
  );

  int id;
  String username;
  String useremail;
  String userpassword;
  String userimage;

  factory StoryUser.fromJson(Map<String, dynamic> json) => StoryUser(
        json["id"],
        json["username"],
        json["useremail"],
        json["userpassword"],
        json["userimage"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "useremail": useremail,
        "userpassword": userpassword,
        "userimage": userimage,
      };
}
