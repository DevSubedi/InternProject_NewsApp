import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:news_app/core/di/injection.dart';

import 'package:news_app/features/home/presentation/screens/favorite_screen.dart';
import 'package:news_app/features/home/presentation/screens/home_screen.dart';
import 'package:news_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:news_app/features/search/domain/repo/search_news_repo.dart';
import 'package:news_app/features/search/presentation/bloc/search_bloc.dart';
import 'package:news_app/features/search/presentation/screens/search_screen.dart';

import 'package:news_app/features/setting/presentation/screens/setting_screen.dart';
import 'package:news_app/l10n/app_localizations.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<NewsPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final currentUser = FirebaseAuth.instance.currentUser;
    final userId = currentUser?.uid;

    final List<Widget> _pages = [
      HomeScreen(),
      FavoriteScreen(),
      BlocProvider(
        create: (context) => SearchBloc(getIt<SearchNewsRepo>())
          ..add(GetSearchTitleEvent(searchTitle: 'Nepal'))
          ..add(PerformSearchEvent()),
        child: SearchScreen(),
      ),
      ProfileScreen(userId: userId ?? ''),
    ];
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
          child: GNav(
            gap: 8.w,
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.blueGrey.shade700,
            padding: EdgeInsets.all(16.w),
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            tabs: [
              GButton(icon: Icons.home, text: l10.home),
              GButton(icon: Icons.favorite, text: l10.favorites),
              GButton(icon: Icons.search, text: l10.search),
              GButton(icon: Icons.person, text: l10.profile),
            ],
          ),
        ),
      ),
    );
  }
}
