import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/features/auth/presentation/widgets/text_widget.dart';
import 'package:news_app/features/home/presentation/bloc/news_bloc.dart';
import 'package:news_app/features/home/presentation/widgets/news_card_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Screen of NewsApp')),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state.status == DataStatus.loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state.status == DataStatus.loaded) {
            return ListView.builder(
              itemCount: state.allNews.length,

              itemBuilder: (context, index) {
                return NewsCardWidget(singleNews: state.allNews[index]);
              },
            );
          } else if (state.status == DataStatus.error) {
            return Center(
              child: TextWidget(word: state.message, size: 30.h),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
// a