import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/core/di/service_locator.dart';
import 'package:news_app/features/home/data/models/news_model.dart';

import 'package:news_app/features/search/data/search_api_service.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState()) {
    on<GetSearchTitleEvent>(_onSearchTitleEvent);
    on<PerformSearchEvent>(_onPerformSearchEvent);
  }

  FutureOr<void> _onSearchTitleEvent(
    GetSearchTitleEvent event,
    Emitter<SearchState> emit,
  ) {
    emit(state.copyWith(searchTitle: event.searchTitle));
  }

  FutureOr<void> _onPerformSearchEvent(
    PerformSearchEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(state.copyWith(status: SearchDataStatus.loading));
    try {
      final api = sl<SearchApiService>();
      final List<NewsModel> response = await api.searchApiMethod(
        state.searchTitle,
      );
      emit(
        state.copyWith(
          status: SearchDataStatus.loaded,
          resultNewsList: response,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: SearchDataStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
