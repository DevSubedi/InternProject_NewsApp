import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/features/auth/presentation/login/widgets/text_widget.dart';
import 'package:news_app/features/home/presentation/widgets/news_card_widget.dart';
import 'package:news_app/features/search/presentation/bloc/search_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
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
                    word: 'Search',
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
                20.verticalSpace,
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16.0.r),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter the news to search',
                  hintText: 'Search News........',
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: IconButton(
                      iconSize: 36,
                      onPressed: () {
                        FocusScope.of(context).unfocus();

                        context.read<SearchBloc>().add(PerformSearchEvent());
                      },
                      icon: Icon(Icons.search),
                    ),
                  ),
                ),

                keyboardType: TextInputType.text,

                onChanged: (value) {
                  context.read<SearchBloc>().add(
                    GetSearchTitleEvent(searchTitle: value),
                  );
                },
                onSubmitted: (value) {
                  context.read<SearchBloc>().add(PerformSearchEvent());
                },
              ),
            ),
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state.status == SearchDataStatus.loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state.status == SearchDataStatus.loaded) {
                  return Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return NewsCardWidget(
                          singleNews: state.resultNewsList[index],
                        );
                      },
                      separatorBuilder: (c, i) {
                        return Divider();
                      },
                      itemCount: state.resultNewsList.length,
                    ),
                  );
                } else if (state.status == SearchDataStatus.error) {
                  return Center(
                    child: TextWidget(word: state.errorMessage, size: 30),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
