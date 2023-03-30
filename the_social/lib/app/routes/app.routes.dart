// ignore_for_file: constant_identifier_names

import 'package:the_social/meta/views/add_post/add_post.views.dart';
import 'package:the_social/meta/views/add_story/add_story.views.dart';
import 'package:the_social/meta/views/authentication/login.views.dart';
import 'package:the_social/meta/views/authentication/signup.views.dart';
import 'package:the_social/meta/views/decider_view/decider_view.dart';
import 'package:the_social/meta/views/home_view/home_view.dart';
import 'package:the_social/meta/views/preview_story/preview_story.view.dart';

const String LoginRoute = "/login";
const String SignUpRoute = "/signup";
const String HomeRoute = "/";
const String DeciderRoute = "/decider";
const String AddPostRoute = "/add-post";
const String AddStoryRoute = "/add-story";
const String PreviewStoryRoute = "/preview-story";

final routes = {
  LoginRoute: (context) => LoginView(),
  SignUpRoute: (context) => SignUpView(),
  DeciderRoute: (context) => const DeciderView(),
  HomeRoute: (context) => HomeView(),
  AddPostRoute: (context) => const AddPostView(),
  AddStoryRoute: (context) => const AddStoryView(),
  PreviewStoryRoute: (context) => const PreviewMyStoryView(),
};
