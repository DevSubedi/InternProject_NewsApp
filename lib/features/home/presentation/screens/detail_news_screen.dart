import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/di/injection.dart';
import 'package:news_app/core/di/service_locator.dart';
import 'package:news_app/core/routing/navigation_service.dart';
import 'package:news_app/core/routing/route_name.dart';
import 'package:news_app/features/ai/domain/repo/ai_repository.dart';
import 'package:news_app/features/ai/presentation/bloc/ai_summary_bloc.dart';
import 'package:news_app/features/auth/presentation/login/widgets/text_widget.dart';
import 'package:news_app/features/home/data/data_source/date_time_service.dart';
import 'package:news_app/features/home/data/models/news_model.dart';
import 'package:news_app/features/home/presentation/bloc/news_bloc.dart';
import 'package:news_app/common/widgets/show_toast_widget.dart';
import 'package:news_app/l10n/app_localizations.dart';

class DetailNewsScreen extends StatelessWidget {
  final NewsModel news;

  const DetailNewsScreen({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    final DateTimeService date = sl<DateTimeService>();
    return BlocProvider(
      create: (context) =>
          AiSummaryBloc(getIt<AiRepository>())
            ..add(GetContentEvent(url: news.webUrl ?? '')),

      child: Scaffold(
        appBar: AppBar(
          title: TextWidget(
            word: l10.detailedNews,
            textColor: Colors.blueAccent,
            size: 32.h,
            weight: FontWeight.w900,
          ),
        ),
        floatingActionButton: Builder(
          builder: (context) {
            return BlocConsumer<AiSummaryBloc, AiSummaryState>(
              listener: (context, state) {
                if (state.status == AiSummaryStatus.loaded) {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (context) => Padding(
                      padding: EdgeInsets.all(16),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.auto_awesome,
                                  color: Colors.blueAccent,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'AI Summary',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Text(
                              state.summary,
                              style: TextStyle(fontSize: 16, height: 1.4),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
              builder: (context, state) {
                final isLoading = state.status == AiSummaryStatus.loading;

                return FloatingActionButton.extended(
                  backgroundColor: Colors.blueAccent,
                  onPressed: () {
                    final bloc = context.read<AiSummaryBloc>();
                    bloc.add(GetSummaryEvent(content: state.content));
                  },
                  icon: isLoading
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Icon(Icons.auto_awesome, color: Colors.white),
                  label: Text(
                    isLoading ? 'Summarizing...' : 'AI Summary',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            );
          },
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: Padding(
          padding: EdgeInsets.all(16.0.w),
          child: BlocListener<NewsBloc, NewsState>(
            listenWhen: (previous, current) {
              return previous.showToastFavorite != current.showToastFavorite;
            },
            listener: (context, state) {
              if (state.showToastFavorite) {
                ShowToastWidget.show('News Added to Favorite');

                // ignore: invalid_use_of_visible_for_testing_member
                context.read<NewsBloc>().emit(
                  state.copyWith(showToastFavorite: false),
                );
              }

              //reset toast so that it doesn't trigger again
            },
            child: Column(
              children: [
                Text('"${news.title}"', style: TextStyle(fontSize: 24.h)),
                Hero(
                  tag: 'newsImage_${news.imageUrl}',
                  child: SizedBox(
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
                ),
                8.verticalSpace,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 250.w,
                      child: Text(
                        ' ${news.author}',
                        style: TextStyle(
                          fontSize: 16.h,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
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
                10.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<NewsBloc, NewsState>(
                      builder: (context, state) {
                        final isFavorite = state.favoriteNewsList.any(
                          (item) => item.title == news.title,
                        );
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            maximumSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            backgroundColor: isFavorite
                                ? Colors.redAccent
                                : Colors.blueAccent,
                            overlayColor: Colors.white.withValues(alpha: 10),
                          ),
                          onPressed: () {
                            if (isFavorite) {
                              context.read<NewsBloc>().add(
                                RemoveFavoriteNewsEvent(newsToRemove: news),
                              );
                            } else {
                              context.read<NewsBloc>().add(
                                AddToFavoriteEvent(news: news),
                              );
                            }
                          },

                          child: TextWidget(
                            word: isFavorite
                                ? 'Remove from Favorites '
                                : l10.buttonText1,
                            size: 16.h,
                            weight: FontWeight.bold,
                            textColor: Colors.white,
                          ),
                        );
                      },
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        maximumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        backgroundColor: Colors.blueAccent,
                        overlayColor: Colors.white.withValues(alpha: 10),
                      ),
                      onPressed: () => NavigationService.pushNamed(
                        RouteName.webview,
                        extra: news.webUrl,
                      ),
                      child: TextWidget(
                        word: 'Read More',

                        size: 16.h,
                        weight: FontWeight.bold,
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
