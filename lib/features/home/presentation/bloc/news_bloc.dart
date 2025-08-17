import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
    emit(state.copyWith(status: DataStatus.loading));
    try {
      final api = sl<NewsApiService>();
      final selected = state.selectedCategory;
      final list = await api.categoryNewsService(
        category: (selected == null || selected.toLowerCase() == 'all')
            ? null
            : selected.toLowerCase(),
      );
      emit(state.copyWith(status: DataStatus.loaded, categoryNews: list));
    } catch (e) {
      emit(
        state.copyWith(
          status: DataStatus.error,
          message: ' Some error in the categorybloc: $e',
        ),
      );
    }
  }
}
