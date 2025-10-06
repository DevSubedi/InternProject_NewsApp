import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/core/di/service_locator.dart';
import 'package:news_app/features/home/data/models/news_model.dart';
import 'package:news_app/features/home/presentation/bloc/news_bloc.dart';

import 'package:news_app/features/search/data/search_api_service.dart';
import 'package:news_app/features/search/domain/repo/search_news_repo.dart';

part 'search_event.dart';
part 'search_state.dart';

@Injectable()
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchNewsRepo repo;
  SearchBloc(this.repo) : super(SearchState()) {
    on<GetSearchTitleEvent>(_onSearchTitleEvent);
    on<PerformSearchEvent>(_onPerformSearchEvent);
    on<PerformPaginationEvent>(_onPerformPaginationEvent);
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
    emit(
      state.copyWith(
        status: SearchDataStatus.loading,
        resultNewsList: [],
        page: 1,
        hasMore: true,
      ),
    );
    final result = await repo.fetchSearchedNews(
      query: state.searchTitle,
      page: 1,
    );
    result.fold(
      (error) => emit(
        state.copyWith(status: SearchDataStatus.error, errorMessage: error),
      ),
      (news) => emit(
        state.copyWith(
          status: SearchDataStatus.loaded,
          resultNewsList: news,
          page: 1,
          hasMore: news.isNotEmpty,
        ),
      ),
    );
  }

  FutureOr<void> _onPerformPaginationEvent(
    PerformPaginationEvent event,
    Emitter<SearchState> emit,
  ) async {
    if (!state.hasMore) return;
    final nextPage = state.page + 1;
    final result = await repo.fetchSearchedNews(
      query: state.searchTitle,
      page: nextPage,
    );
    result.fold(
      (error) => emit(
        state.copyWith(status: SearchDataStatus.error, errorMessage: error),
      ),
      (news) => emit(
        state.copyWith(
          status: SearchDataStatus.loaded,
          resultNewsList: [...state.resultNewsList, ...news],
          page: nextPage,
          hasMore: news.isNotEmpty,
        ),
      ),
    );
  }
}

  // FutureOr<void> _onPerformSearchEvent(
  //   PerformSearchEvent event,
  //   Emitter<SearchState> emit,
  // ) async {
  //   emit(state.copyWith(status: SearchDataStatus.loading));
  //   try {
  //     final api = sl<SearchApiService>();
  //     final List<NewsModel> response = await api.searchApiMethod(
  //       state.searchTitle,
  //     );
  //     emit(
  //       state.copyWith(
  //         status: SearchDataStatus.loaded,
  //         resultNewsList: response,
  //       ),
  //     );
  //   } catch (e) {
  //     emit(
  //       state.copyWith(
  //         status: SearchDataStatus.error,
  //         errorMessage: e.toString(),
  //       ),
  //     );
  //   }
  // }