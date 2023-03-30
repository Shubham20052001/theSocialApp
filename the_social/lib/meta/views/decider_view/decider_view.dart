import 'package:flutter/material.dart';
import 'package:the_social/core/services/cache.service.dart';
import 'package:the_social/meta/views/authentication/login.views.dart';
import 'package:the_social/meta/views/splash_view/splash_view.dart';

import '../home_view/home_view.dart';

class DeciderView extends StatelessWidget {
  const DeciderView({super.key});

  @override
  Widget build(BuildContext context) {
    final CacheService cacheService = CacheService();
    return FutureBuilder(
      future: cacheService.readCache(key: "jwt"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          print("splash view");
          return const SplashView();
        }
        if (snapshot.hasData) {
          print("home view");
          return HomeView();
        } else {
          print("login view");
          return LoginView();
        }
      },
    );
  }
}
