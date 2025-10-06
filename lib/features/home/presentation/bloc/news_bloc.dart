import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:news_app/core/di/service_locator.dart';
import 'package:news_app/features/home/data/data_source/news_api_service.dart';
import 'package:news_app/features/home/data/models/news_model.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsState()) {
    on<FetchAllNewsEvent>(_onFetchAllNewsEvent);
    on<SelectCategoryEvent>(_onSelectCategoryEvent);
    on<FetchCategoryNewsEvent>(_onFetchCategoryNewsEvent);
    on<AddToFavoriteEvent>(_onAddToFavoriteEvent);
    on<RemoveFavoriteNewsEvent>(_onRemoveFavoriteNewsEvent);

    // Load favorites from Hive when Bloc starts
    final box = Hive.box<NewsModel>('favoriteNewsBox');
    final savedFavorites = box.keys.map((key) {
      final news = box.get(key);
      if (news != null) {
        news.hiveKey =
            key; // attach hiveKey so deletion works didn't get it though // period
      }
      return news!;
    }).toList();

    emit(state.copyWith(favoriteNewsList: savedFavorites));
  }

  FutureOr<void> _onFetchAllNewsEvent(
    FetchAllNewsEvent event,
    Emitter<NewsState> emit,
  ) async {
    emit(state.copyWith(status: DataStatus.loading));
    try {
      final NewsApiService getNews = sl<NewsApiService>();
      final data = await getNews.getNewsService();
      emit(state.copyWith(status: DataStatus.loaded, allNews: data));
    } catch (e) {
      emit(
        state.copyWith(
          status: DataStatus.error,
          message: ' Some error in the bloc: $e',
        ),
      );
    }
  }

  FutureOr<void> _onSelectCategoryEvent(
      SelectCategoryEvent event,
    Emitter<NewsState> emit,
  ) {
    emit(
      state.copyWith(
        selectedCategory: event.selectedCategoryEvent,
        categoryNews: [],
      ),
    );

    add(
      FetchCategoryNewsEvent(),
    ); // immediately calling the fetch news select garna paxaina
  }

  FutureOr<void> _onFetchCategoryNewsEvent(
    FetchCategoryNewsEvent event,
    Emitter<NewsState> emit,
  ) async {
    emit(state.copyWith(categoryStatus: DataStatus.loading));
    try {
      final api = sl<NewsApiService>();
      final selected = state.selectedCategory;
      final list = await api.categoryNewsService(
        category: (selected == null || selected.toLowerCase() == 'all')
            ? null
            : selected.toLowerCase(),
      );
      emit(
        state.copyWith(categoryStatus: DataStatus.loaded, categoryNews: list),
      );
    } catch (e) {
      emit(
        state.copyWith(
          categoryStatus: DataStatus.error,
          message: ' Some error in the categorybloc: $e',
        ),
      );
    }
  }

  Future<void> _onAddToFavoriteEvent(
    AddToFavoriteEvent event,
    Emitter<NewsState> emit,
  ) async {
    final box = Hive.box<NewsModel>('favoriteNewsBox');
    emit(state.copyWith(favoriteNews: event.news));
    final news = state.favoriteNews;
    final FavoriteList = List<NewsModel>.from(state.favoriteNewsList);

    // check if already exists
    final alreadyExists = FavoriteList.any(
      (news) => news.title == event.news.title,
    );

    if (!alreadyExists) {
      FavoriteList.add(event.news);
      // Save to Hive and get the key
      final key = await box.add(event.news );
      //save the key inside the model
      event.news.hiveKey = key;

      emit(
        state.copyWith(showToastFavorite: true, favoriteNewsList: FavoriteList),
      );
    }
    // else {
    //   emit(state.copyWith(showToastFavorite: false));
    // }
  }

  FutureOr<void> _onRemoveFavoriteNewsEvent(
    RemoveFavoriteNewsEvent event,
    Emitter<NewsState> emit,
  ) async {
    final box = Hive.box<NewsModel>('favoriteNewsBox');
    emit(state.copyWith(newsToRemove: event.newsToRemove));
    final newsToRemove = event.newsToRemove;
    final FavoriteList = List<NewsModel>.from(state.favoriteNewsList);

    // removing from the list
    FavoriteList.remove(newsToRemove);

    //remove from the hive using hiveKey

    if (newsToRemove?.hiveKey != null) {
      await box.delete(newsToRemove!.hiveKey!);
    }

    emit(
      state.copyWith(
        showToastNewsDeletion: true,
        favoriteNewsList: FavoriteList,
      ),
    );
  }
}
