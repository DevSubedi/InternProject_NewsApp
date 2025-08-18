import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:news_app/features/auth/presentation/widgets/text_widget.dart';
import 'package:news_app/features/home/presentation/bloc/news_bloc.dart';
import 'package:news_app/features/home/presentation/widgets/category_tab_widget.dart';

import 'package:news_app/features/home/presentation/widgets/trending_news_widget.dart';

class HomeScreen extends StatelessWidget {
  final bool showBottomNav;
  const HomeScreen({super.key, this.showBottomNav = true});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              //   TextWidget(
              //     word: 'Flutter',
              //     size: 36.h,
              //     textColor: Colors.black,
              //     weight: FontWeight.bold,
              //   ),
              //   TextWidget(word: 'News', size: 36.h, textColor: Colors.blue),
              //
              10.horizontalSpace,
              SvgPicture.asset(
                'assets/logo.svg',
                height: 36.h,

                fit: BoxFit.contain,
              ),
            ],
          ),
          Divider(),

          Expanded(
            child: BlocBuilder<NewsBloc, NewsState>(
              builder: (context, state) {
                if (state.status == DataStatus.loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state.status == DataStatus.loaded) {
                  return TrendingNewsWidget(newsList: state.allNews);
                } else if (state.status == DataStatus.error) {
                  return Center(
                    child: TextWidget(word: state.message, size: 30.h),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),

          Expanded(child: CategoryTabWidget()),
        ],
      ),
    );
  }
}
