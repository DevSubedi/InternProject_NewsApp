import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/routing/route_name.dart';
import 'package:news_app/features/auth/presentation/screens/login_screen.dart';
import 'package:news_app/features/home/data/models/news_model.dart';
import 'package:news_app/features/home/presentation/screens/detail_news_screen.dart';
import 'package:news_app/features/home/presentation/screens/home_screen.dart';

GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
final GoRouter appRouter = GoRouter(
  navigatorKey: navigationKey,
  initialLocation: RoutePath.home,
  routes: [
    GoRoute(
      path: RoutePath.home,
      name: RouteName.home,
      builder: (context, state) => HomeScreen(),
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
  ],
);
