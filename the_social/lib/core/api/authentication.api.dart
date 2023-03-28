import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:the_social/app/routes/api.routes.dart';

import '../notifier/authentication.notifier.dart';

class AuthenticationAPI {
  final client = http.Client();

  //! Create new user
  Future signup(
      {required String username,
      required String useremail,
      required String userpassword,
      required String userimage}) async {
    const String subUrl = "/user/signup";
    final Uri uri = Uri.parse(APIRoutes.BaseURL + subUrl);
    final http.Response response = await client.post(
      uri,
      body: jsonEncode({
        "username": username,
        "useremail": useremail,
        "userpassword": userpassword,
        "userimage": userimage,
      }),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Access-Control-Allow-Origin': '*',
      },
    );

    final statusCode = response.statusCode;
    final body = response.body;

    if (statusCode == 200) {
      // print(body);
      return body;
    }
  }

  //! Login user
  Future login({
    required String email,
    required String password,
  }) async {
    const String subUrl = "/user/login";
    final Uri uri = Uri.parse(APIRoutes.BaseURL + subUrl);
    final http.Response response = await client.post(
      uri,
      body: jsonEncode({"useremail": email, "userpassword": password}),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Access-Control-Allow-Origin': '*',
      },
    );

    final statusCode = response.statusCode;
    final body = response.body;

    if (statusCode == 200) {
      // print(body);
      return body;
    }
  }

  //! Decode Jwt
  Future decodeJwt({required dynamic token}) async {
    const String subUrl = "/user/decode-jwt";
    final Uri uri = Uri.parse(APIRoutes.BaseURL + subUrl);
    final http.Response response = await client.get(
      uri,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Authorization': token,
      },
    );

    final statusCode = response.statusCode;
    final body = response.body;
    if (statusCode == 200) {
      return body;
    }
  }

  //! Get User Data
  Future getUserData({required BuildContext context}) async {
    final authenticationNotifier =
        Provider.of<AuthenticationNotifier>(context, listen: true);
    String email =
        await authenticationNotifier.fetchUserEmail(context: context);
    const String subUrl = "/user/details";
    final Uri uri = Uri.parse(APIRoutes.BaseURL + subUrl);
    final http.Response response = await client.post(
      uri,
      body: jsonEncode({"useremail": email}),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Access-Control-Allow-Origin': '*',
      },
    );

    final statusCode = response.statusCode;
    final body = response.body;
    if (statusCode == 200) {
      // print(body);
      return body;
    }
  }
}
