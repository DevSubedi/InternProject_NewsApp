import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:news_app/features/auth/presentation/login/widgets/text_widget.dart';
import 'package:news_app/features/home/presentation/bloc/news_bloc.dart';
import 'package:news_app/features/home/presentation/widgets/category_tab_widget.dart';

import 'package:news_app/features/home/presentation/widgets/trending_news_widget.dart';

class HomeScreen extends StatelessWidget {
  final bool showBottomNav;
  const HomeScreen({super.key, this.showBottomNav = true});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 7, // categories count
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              /// 🔹 AppBar / Logo
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        10.horizontalSpace,
                        SvgPicture.asset(
                          'assets/logo.svg',
                          height: 36.h,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                    Divider(),
                  ],
                ),
              ),

              /// 🔹 Trending Section
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    BlocBuilder<NewsBloc, NewsState>(
                      builder: (context, state) {
                        if (state.status == DataStatus.loading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state.status == DataStatus.loaded) {
                          return TrendingNewsWidget(newsList: state.allNews);
                        } else if (state.status == DataStatus.error) {
                          return Center(
                            child: TextWidget(word: state.message, size: 30.h),
                          );
                        }
                        return Container();
                      },
                    ),
                    20.verticalSpace,
                  ],
                ),
              ),

              /// Latest Text pinned
              SliverPersistentHeader(
                pinned: true,
                delegate: _TextHeaderDelegate(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.h),
                    child: Text(
                      'Latest',
                      style: TextStyle(
                        fontSize: 18.h,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              SliverPersistentHeader(
                pinned: true,
                delegate: _TabBarDelegate(
                  TabBar(
                    isScrollable: true,

                    enableFeedback: true,
                    dividerHeight: 0,
                    tabAlignment: TabAlignment.start,
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.black,
                    indicatorColor: Colors.blue,

                    // isScrollable: true,
                    // labelColor: Colors.blue,
                    // unselectedLabelColor: Colors.black,
                    // dividerColor: Colors.transparent,
                    tabs: const [
                      Tab(text: 'All'),
                      Tab(text: 'Technology'),
                      Tab(text: 'Business'),
                      Tab(text: 'Entertainment'),
                      Tab(text: 'General'),
                      Tab(text: 'Health'),
                      Tab(text: 'Science'),
                    ],
                  ),
                ),
              ),
            ];
          },

          body: CategoryTabWidget(),
        ),
      ),
    );
  }
}

class _TextHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  _TextHeaderDelegate({required this.child});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final color = shrinkOffset > 0 ? Colors.white : Colors.transparent;
    return Container(
      color: color,
      alignment: Alignment.centerLeft,
      child: child,
    );
  }

  @override
  double get maxExtent => 40.h; // height of the Latest text
  @override
  double get minExtent => 40.h;

  @override
  bool shouldRebuild(_TextHeaderDelegate oldDelegate) => false;
}

/// Helper delegate for TabBar (keeps it pinned)
class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  _TabBarDelegate(this.tabBar);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final color = shrinkOffset > 0 ? Colors.white : Colors.transparent;
    return Container(
      color: color, // background for pinned tab
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(_TabBarDelegate oldDelegate) {
    return false;
  }
}







//before the nestedScrollView



// class HomeScreen extends StatelessWidget {
//   final bool showBottomNav;
//   const HomeScreen({super.key, this.showBottomNav = true});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,

//             children: [
//               //   TextWidget(
//               //     word: 'Flutter',
//               //     size: 36.h,
//               //     textColor: Colors.black,
//               //     weight: FontWeight.bold,
//               //   ),
//               //   TextWidget(word: 'News', size: 36.h, textColor: Colors.blue),
//               //
//               10.horizontalSpace,
//               SvgPicture.asset(
//                 'assets/logo.svg',
//                 height: 36.h,

//                 fit: BoxFit.contain,
//               ),
//             ],
//           ),
//           Divider(),

//           Expanded(
//             child: BlocBuilder<NewsBloc, NewsState>(
//               builder: (context, state) {
//                 if (state.status == DataStatus.loading) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (state.status == DataStatus.loaded) {
//                   return TrendingNewsWidget(newsList: state.allNews);
//                 } else if (state.status == DataStatus.error) {
//                   return Center(
//                     child: TextWidget(word: state.message, size: 30.h),
//                   );
//                 } else {
//                   return Container();
//                 }
//               },
//             ),
//           ),

//           Expanded(child: CategoryTabWidget()),
//         ],
//       ),
//     );
//   }
// }
