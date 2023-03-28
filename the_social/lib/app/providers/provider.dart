import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:the_social/core/notifier/authentication.notifier.dart';
import 'package:the_social/core/notifier/post.notifier.dart';
import 'package:the_social/core/notifier/story.notifier.dart';
import 'package:the_social/core/notifier/utility.notifier.dart';

List<SingleChildWidget> providers = [...remoteProvider];

//! Independent Providers
List<SingleChildWidget> remoteProvider = [
  ChangeNotifierProvider(create: (_) => AuthenticationNotifier()),
  ChangeNotifierProvider(create: (_) => UtilityNotifier()),
  ChangeNotifierProvider(create: (_) => PostNotifier()),
  ChangeNotifierProvider(create: (_) => StoryNotifier())
];
