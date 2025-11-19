import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/features/auth/presentation/login/widgets/text_widget.dart';
import 'package:news_app/features/home/presentation/widgets/news_card_widget.dart';
import 'package:news_app/features/search/presentation/bloc/search_bloc.dart';
import 'package:news_app/features/search/presentation/widgets/animated_list_item.dart';
import 'package:news_app/l10n/app_localizations.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final state = context.read<SearchBloc>().state;
    if (state.hasMore &&
        state.status != SearchDataStatus.loading &&
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 300) {
      context.read<SearchBloc>().add(PerformPaginationEvent());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
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
                    word: 'News',
                    size: 32.h,
                    weight: FontWeight.w700,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4.0.w),
                  child: TextWidget(
                    word: l10.search,
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
                if (state.status == SearchDataStatus.loading &&
                    state.page == 1) {
                  return Center(child: CircularProgressIndicator());
                } else if (state.status == SearchDataStatus.loaded) {
                  return Expanded(
                    child: ListView.separated(
                      controller: _scrollController,
                      itemBuilder: (context, index) {
                        if (index < state.resultNewsList.length) {
                          final news = state.resultNewsList[index];
                          return AnimatedListItem(
                            child: NewsCardWidget(singleNews: news),
                          ); // your news item widget
                        } else {
                          // Show bottom loader when paginating
                          return state.hasMore
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : const SizedBox.shrink();
                        }
                      },
                      separatorBuilder: (c, i) {
                        return Divider();
                      },
                      itemCount:
                          state.resultNewsList.length + (state.hasMore ? 1 : 0),
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
