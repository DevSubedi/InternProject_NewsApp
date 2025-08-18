// class NewsCardWidget {

// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/di/service_locator.dart';
import 'package:news_app/core/routing/navigation_service.dart';
import 'package:news_app/core/routing/route_name.dart';
import 'package:news_app/features/auth/presentation/widgets/text_widget.dart';
import 'package:news_app/features/home/data/data_source/date_time_service.dart';
import 'package:news_app/features/home/data/models/news_model.dart';
import 'package:news_app/features/home/presentation/screens/detail_news_screen.dart';

class NewsCardWidget extends StatelessWidget {
  final NewsModel singleNews;

  const NewsCardWidget({super.key, required this.singleNews});

  @override
  Widget build(BuildContext context) {
    final DateTimeService date = sl<DateTimeService>();
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(8.r),
        height: 130.h,
        width: 400.w,
        child: Row(
          children: [
            Container(
              height: 100,
              width: 100,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.h),
              ),
              child: Image.network(
                singleNews.imageUrl?.isNotEmpty == true
                    ? singleNews.imageUrl!
                    : 'https://via.placeholder.com/150',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/image-load-failed.png',
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 4.h, left: 8.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 20.0.w),
                      child: Text(
                        '${singleNews.title}',
                        style: TextStyle(
                          fontSize: 13.h,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4E4B66),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    4.verticalSpace,
                    Text(
                      singleNews.description ?? 'xxxxxxxxxxxxxxxxx',
                      style: TextStyle(
                        fontSize: 16.h,
                        color: Color(0xFF000000),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    4.verticalSpace,
                    Row(
                      children: [
                        Icon(Icons.person, size: 20.r),
                        4.horizontalSpace,
                        SizedBox(
                          width: 100.w,
                          child: Text(
                            singleNews.author ?? 'xxxx',
                            style: TextStyle(
                              fontSize: 12.h,
                              color: Color(0xFF000000),
                              fontStyle: FontStyle.italic,
                            ),

                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        8.horizontalSpace,
                        Icon(Icons.access_time_sharp, size: 20.r),
                        4.horizontalSpace,
                        TextWidget(
                          word: date.dateParser(singleNews.publishedAt ?? ''),

                          size: 12.h,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        NavigationService.pushNamed(RouteName.detailScreen, extra: singleNews);
      },
    );
  }
}
