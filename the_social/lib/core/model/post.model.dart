// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  Post(
    this.code,
    this.data,
    this.received,
  );

  int code;
  List<PostData> data;
  bool received;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        json["code"],
        List<PostData>.from(json["data"].map((x) => PostData.fromJson(x))),
        json["received"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "received": received,
      };
}

class PostData {
  PostData(
    this.postId,
    this.postTitle,
    this.postImages,
    this.postTime,
    this.postComments,
    this.postLikes,
    this.postUser,
  );

  int postId;
  String postTitle;
  List<String> postImages;
  DateTime postTime;
  dynamic postComments;
  dynamic postLikes;
  PostUser postUser;

  factory PostData.fromJson(Map<String, dynamic> json) => PostData(
        json["post_id"],
        json["post_title"],
        List<String>.from(json["post_images"].map((x) => x)),
        DateTime.parse(json["post_time"]),
        json["post_comments"],
        json["post_likes"],
        PostUser.fromJson(json["post_user"]),
      );

  Map<String, dynamic> toJson() => {
        "post_id": postId,
        "post_title": postTitle,
        "post_images": List<dynamic>.from(postImages.map((x) => x)),
        "post_time": postTime.toIso8601String(),
        "post_comments": postComments,
        "post_likes": postLikes,
        "post_user": postUser.toJson(),
      };
}

class PostUser {
  PostUser(
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

  factory PostUser.fromJson(Map<String, dynamic> json) => PostUser(
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
