import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_social/app/routes/app.routes.dart';
import 'package:the_social/core/api/authentication.api.dart';
import 'package:the_social/core/services/cache.service.dart';

class AuthenticationNotifier extends ChangeNotifier {
  final AuthenticationAPI _authenticationAPI = AuthenticationAPI();
  final CacheService cacheService = CacheService();

  Future signup(
      {required BuildContext context,
      required String username,
      required String useremail,
      required String userpassword,
      required String userimage}) async {
    try {
      var userData = await _authenticationAPI.signup(
          username: username,
          useremail: useremail,
          userpassword: userpassword,
          userimage: userimage);
      final Map<String, dynamic> parsedValue = await jsonDecode(userData);
      final userJwt = parsedValue['message'];
      final userCode = parsedValue['code'];
      if (userCode == 201) {
        cacheService.writeCache(key: "jwt", value: userJwt);
        Navigator.of(context).pushNamed(HomeRoute);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(userJwt)));
      }
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Error signing up.")));
    }
  }

  Future login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      var userData =
          await _authenticationAPI.login(email: email, password: password);
      final Map<String, dynamic> parsedValue = await jsonDecode(userData);
      final userJwt = parsedValue['message'];
      final userCode = parsedValue['code'];
      if (userCode == 201) {
        cacheService.writeCache(key: "jwt", value: userJwt);
        Navigator.of(context).pushNamed(HomeRoute);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(userJwt)));
      }
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Something went wrong.")));
    }
  }

  Future decodeJwt({required dynamic token}) async {
    try {
      var response = await _authenticationAPI.decodeJwt(token: token);
      return response;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> fetchUserEmail({required BuildContext context}) async {
    var token = await cacheService.readCache(key: "jwt");
    var dataToken = await decodeJwt(token: token);
    final Map<String, dynamic> parsedTokenData = await jsonDecode(dataToken);
    final userEmail = parsedTokenData['message'];
    return userEmail;
  }
}
