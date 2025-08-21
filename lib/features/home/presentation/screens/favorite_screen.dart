import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/common/widgets/show_toast_widget.dart';
import 'package:news_app/features/auth/presentation/login/widgets/text_widget.dart';
import 'package:news_app/features/home/presentation/bloc/news_bloc.dart';
import 'package:news_app/features/home/presentation/widgets/news_card_widget.dart';
import 'package:news_app/l10n/app_localizations.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context)!;
    return SafeArea(
      child: BlocListener<NewsBloc, NewsState>(
        listenWhen: (previous, current) {
          return previous.showToastNewsDeletion !=
              current.showToastNewsDeletion;
        },
        listener: (context, state) {
          if (state.showToastNewsDeletion) {
            ShowToastWidget.show('News Sucessfully deleted');
            context.read<NewsBloc>().emit(
              state.copyWith(showToastNewsDeletion: false),
            );
          }
        },
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
                    word: l10.favorites,
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
                      return Slidable(
                        key: ValueKey(favoriteNews.title),
                        endActionPane: ActionPane(
                          motion: const DrawerMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                context.read<NewsBloc>().add(
                                  RemoveFavoriteNewsEvent(
                                    newsToRemove: favoriteNews,
                                  ),
                                );
                              },
                              backgroundColor: Colors.red,
                              icon: Icons.delete,
                              label: 'Delete',
                            ),
                          ],
                        ),
                        child: NewsCardWidget(singleNews: favoriteNews),
                      );
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
      ),
    );
  }
}
