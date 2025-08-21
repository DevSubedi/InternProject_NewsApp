import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/routing/navigation_service.dart';
import 'package:news_app/core/routing/route_name.dart';
import 'package:news_app/features/auth/presentation/login/widgets/text_widget.dart';
import 'package:news_app/features/home/data/models/news_model.dart';
import 'package:news_app/l10n/app_localizations.dart';

class TrendingNewsWidget extends StatelessWidget {
  final List<NewsModel> newsList;
  const TrendingNewsWidget({super.key, required this.newsList});

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    Widget buildImage(String urlImage, int index, String name) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.w),

                child: Image.network(
                  urlImage.isNotEmpty == true
                      ? urlImage
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
            ),
            Container(
              height: 250.h,
              padding: EdgeInsets.only(left: 8.w),
              margin: EdgeInsets.only(top: 170.h),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.r),
                  bottomRight: Radius.circular(10.r),
                ),
              ),
              child: Text(
                name,
                maxLines: 2,

                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.h,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                word: l10.trending,
                size: 18.h,
                weight: FontWeight.w600,
              ),
              TextButton(
                onPressed: () {
                  NavigationService.pushNamed(RouteName.trendingNews);
                },
                child: TextWidget(word: l10.viewAll),
              ),
            ],
          ),
        ),

        CarouselSlider.builder(
          itemCount: newsList.length,
          itemBuilder: (context, index, readIndex) {
            NewsModel singleNews = newsList[index];
            String image = singleNews.imageUrl ?? '';
            String title = singleNews.title ?? 'Anonymous';
            return InkWell(
              child: buildImage(image, index, title),
              onTap: () {
                NavigationService.pushNamed(
                  RouteName.detailScreen,
                  extra: newsList[index],
                );
              },
            );
          },
          options: CarouselOptions(
            height: 250.h,

            enlargeCenterPage: true,
            autoPlay: true,

            // autoPlayAnimationDuration: Duration(microseconds: 1000),
            enlargeStrategy: CenterPageEnlargeStrategy.height,
          ),
        ),
      ],
    );
  }
}
