import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/di/service_locator.dart';
import 'package:news_app/features/auth/presentation/widgets/text_widget.dart';
import 'package:news_app/features/home/data/data_source/date_time_service.dart';
import 'package:news_app/features/home/data/models/news_model.dart';
import 'package:news_app/features/home/presentation/widgets/news_app_Bar_widget.dart';

class DetailNewsScreen extends StatelessWidget {
  final NewsModel news;
  // final String? author = 'Leonardo Da Vinci Junior';
  // final String? title = 'Messi is goat';
  // final String? description =
  //     "Messi is the best player in the word. Currently there is no one ever been like messi except of few who are Cristiano Ronaldo ";
  // final String? imageUrl =
  //     'https://image.cnbcfm.com/api/v1/image/108181661-1754399306431-gettyimages-2228105320-wmr51241_xugz3w6r.jpeg?v=1754399390&w=1920&h=1080';
  // final String? publishedAt = '2025-08-07T06:32:57Z';
  // final String? content =
  //     'U.S. President Donald Trumps so-called \"reciprocal\" tariffs took effect on Thursday, imposing higher duties on many of the countrys trading partners exports to the U.S.\r\n\"ITS MIDNIGHT!!! BILLIONS… [+2919 chars]';

  const DetailNewsScreen({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    final DateTimeService date = sl<DateTimeService>();
    return Scaffold(
      appBar: AppBar(title: Text('Detailed Page')),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Container(
          child: Column(
            children: [
              Text('"${news.title}"', style: TextStyle(fontSize: 24.h)),
              SizedBox(
                height: 248.h,
                width: 400.w,

                child: Image.network(news.imageUrl ?? '', fit: BoxFit.fill),
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
              TextWidget(word: news.description ?? '', size: 14.h),
            ],
          ),
        ),
      ),
    );
  }
}
