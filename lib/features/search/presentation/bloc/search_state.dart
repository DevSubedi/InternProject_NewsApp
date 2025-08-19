part of 'search_bloc.dart';

enum SearchDataStatus { initial, loading, loaded, error }

class SearchState extends Equatable {
  final String searchTitle;
  final List<NewsModel> resultNewsList;
  final SearchDataStatus status;
  final String errorMessage;
  const SearchState({
    this.searchTitle = '',
    this.resultNewsList = const [],
    this.status = SearchDataStatus.initial,
    this.errorMessage = '',
  });

  SearchState copyWith({
    String? searchTitle,
    List<NewsModel>? resultNewsList,
    SearchDataStatus? status,
    String? errorMessage,
  }) {
    return SearchState(
      searchTitle: searchTitle ?? this.searchTitle,
      resultNewsList: resultNewsList ?? this.resultNewsList,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, resultNewsList, searchTitle];
}
