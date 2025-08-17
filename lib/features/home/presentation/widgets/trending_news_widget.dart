import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/routing/navigation_service.dart';
import 'package:news_app/core/routing/route_name.dart';
import 'package:news_app/features/auth/presentation/widgets/text_widget.dart';
import 'package:news_app/features/home/data/models/news_model.dart';

class TrendingNewsWidget extends StatelessWidget {
  final List<NewsModel> newsList;
  const TrendingNewsWidget({super.key, required this.newsList});

  @override
  Widget build(BuildContext context) {
    Widget buildImage(String urlImage, int index, String name) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.w),

              child: Image.network(
                height: 250.h,
                urlImage,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
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
              TextWidget(word: 'Trending', size: 18.h, weight: FontWeight.w600),
              TextButton(
                onPressed: () {
                  NavigationService.pushNamed(RouteName.trendingNews);
                },
                child: TextWidget(word: 'View All'),
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
            autoPlay: false,

            // autoPlayAnimationDuration: Duration(microseconds: 1000),
            enlargeStrategy: CenterPageEnlargeStrategy.height,
          ),
        ),
      ],
    );
  }
}
