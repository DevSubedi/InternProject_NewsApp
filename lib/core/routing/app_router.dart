import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/routing/route_name.dart';
import 'package:news_app/features/home/home_screen.dart';

GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
final GoRouter appRouter = GoRouter(
  navigatorKey: navigationKey,
  initialLocation: RouteName.homeScreen,
  routes: [
    GoRoute(
      path: RouteName.homeScreen,
      builder: (context, state) => HomeScreen(),
    ),
  ],
);
