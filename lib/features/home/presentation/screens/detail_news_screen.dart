import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/core/di/service_locator.dart';
import 'package:news_app/features/auth/presentation/widgets/text_widget.dart';
import 'package:news_app/features/home/data/data_source/date_time_service.dart';
import 'package:news_app/features/home/data/models/news_model.dart';
import 'package:news_app/features/home/presentation/bloc/news_bloc.dart';
import 'package:news_app/features/home/presentation/widgets/show_toast_widget.dart';

class DetailNewsScreen extends StatelessWidget {
  final NewsModel news;

  const DetailNewsScreen({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    final DateTimeService date = sl<DateTimeService>();
    return Scaffold(
      appBar: AppBar(title: Text('Detailed Page')),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: BlocListener<NewsBloc, NewsState>(
          listenWhen: (previous, current) {
            return previous.showToastFavorite != current.showToastFavorite;
          },
          listener: (context, state) {
            if (state.showToastFavorite) {
              ShowToastWidget.show('News Added to Favorite');
            }

            //reset toast so that it doesn't trigger again
            // context.read<NewsBloc>().emit(
            //   state.copyWith(showToastCategory: false),
            // );
          },
          child: Container(
            child: Column(
              children: [
                Text('"${news.title}"', style: TextStyle(fontSize: 24.h)),
                SizedBox(
                  height: 248.h,
                  width: 400.w,

                  child: Image.network(
                    news.imageUrl?.isNotEmpty == true
                        ? news.imageUrl!
                        : 'https://via.placeholder.com/150',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/image-load-failed.png',
                        fit: BoxFit.contain,
                      );
                    },
                  ),
                ),
                8.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      word: ' ${news.author}',
                      size: 16.h,
                      weight: FontWeight.bold,
                    ),
                    TextWidget(
                      word:
                          "Published ${date.dateParser(news.publishedAt ?? '')}",
                      size: 16.h,
                    ),
                  ],
                ),
                Divider(),
                TextWidget(word: news.content ?? '', size: 14.h),
                Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    maximumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    backgroundColor: Colors.blueGrey,
                    overlayColor: Colors.white.withValues(alpha: 10),
                  ),
                  onPressed: () {
                    context.read<NewsBloc>().add(
                      AddToFavoriteEvent(news: news),
                    );
                  },

                  child: TextWidget(
                    word: 'Add To Favorite',
                    size: 20.h,
                    weight: FontWeight.bold,
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
