import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:news_app/core/routing/route_name.dart';
import 'package:news_app/features/auth/presentation/login/screens/login_screen.dart';
import 'package:news_app/features/auth/presentation/signup/screens/sign_up_screen.dart';
import 'package:news_app/features/home/data/models/news_model.dart';
import 'package:news_app/features/home/presentation/screens/detail_news_screen.dart';
import 'package:news_app/features/home/presentation/screens/favorite_screen.dart';
import 'package:news_app/features/home/presentation/screens/home_screen.dart';
import 'package:news_app/features/home/presentation/screens/news_page.dart';
import 'package:news_app/features/home/presentation/screens/trending_news_screen.dart';
import 'package:news_app/features/home/presentation/screens/webview_screen.dart';
import 'package:news_app/features/profile/presentation/screens/profile_screen.dart';

import 'package:news_app/features/setting/presentation/screens/setting_screen.dart';

GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: navigationKey,
  initialLocation: Hive.box('authBox').get('isLoggedIn', defaultValue: false)
      ? RoutePath.newsPage
      : RoutePath.login,
  //RoutePath.login,
  routes: [
    GoRoute(
      path: RoutePath.newsPage,
      name: RouteName.newsPage,
      builder: (context, state) => NewsPage(),
    ),
    GoRoute(
      path: RoutePath.home,
      name: RouteName.home,
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: RoutePath.signUp,
      name: RouteName.signUp,
      builder: (context, state) => Material(child: SignUpScreen()),
    ),
    GoRoute(
      path: RoutePath.login,
      name: RouteName.login,
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: RoutePath.detailScreen,
      name: RouteName.detailScreen,
      builder: (context, state) {
        final NewsModel news = state.extra as NewsModel;
        return DetailNewsScreen(news: news);
      },
    ),
    GoRoute(
      path: RoutePath.setting,
      name: RouteName.setting,
      builder: (context, state) => SettingScreen(),
    ),
    GoRoute(
      path: RoutePath.favorite,
      name: RouteName.favorite,
      builder: (context, state) => FavoriteScreen(),
    ),
    GoRoute(
      path: RoutePath.trendingNews,
      name: RouteName.trendingNews,
      builder: (context, state) => TrendingNewsScreen(),
    ),
    GoRoute(
      path: RoutePath.profile,
      name: RouteName.profile,
      builder: (context, state) {
        final currentUser = FirebaseAuth.instance.currentUser;
        final userId = currentUser?.uid;

        return ProfileScreen(userId: 'userId');
      },
    ),
    GoRoute(
      path: RoutePath.webview,
      name: RouteName.webview,
      builder: (context, state) {
        final String url = state.extra as String;
        return WebviewScreen(url: url);
      },
    ),
  ],
);
