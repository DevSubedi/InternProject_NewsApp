import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/features/auth/presentation/login/widgets/text_widget.dart';
import 'package:news_app/features/home/presentation/bloc/news_bloc.dart';
import 'package:news_app/features/home/presentation/widgets/news_card_widget.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: SvgPicture.asset(
              'assets/logo.svg',
              height: 36.h,

              fit: BoxFit.contain,
            ),
          ),
          10.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.0.w),
                child: TextWidget(
                  word: 'Favorite',
                  size: 32.h,
                  weight: FontWeight.w700,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 4.0.w),
                child: TextWidget(
                  word: 'News',
                  size: 32.h,
                  weight: FontWeight.w700,
                  textColor: Colors.blueAccent,
                ),
              ),
            ],
          ),
          Expanded(
            child: BlocBuilder<NewsBloc, NewsState>(
              builder: (context, state) {
                return ListView.separated(
                  itemBuilder: (context, index) {
                    final favoriteNews = state.favoriteNewsList[index];
                    return NewsCardWidget(singleNews: favoriteNews);
                  },
                  separatorBuilder: (c, i) {
                    return Divider();
                  },
                  itemCount: state.favoriteNewsList.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
