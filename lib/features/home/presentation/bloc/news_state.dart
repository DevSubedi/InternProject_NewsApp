part of 'news_bloc.dart';

enum DataStatus { intial, loading, loaded, error }

class NewsState extends Equatable {
  final DataStatus status;
  final List<NewsModel> allNews;
  final NewsModel individualNews;
  final String message;

  const NewsState({
    this.allNews = const [],
    this.individualNews = NewsModel.emptyNewsModel,
    this.message = '',
    this.status = DataStatus.intial,
  });

  NewsState copyWith({
    DataStatus? status,
    List<NewsModel>? allNews,
    NewsModel? individualNews,
    String? message,
  }) {
    return NewsState(
      status: status ?? this.status,
      allNews: allNews ?? this.allNews,
      message: message ?? this.message,
      individualNews: individualNews ?? this.individualNews,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [allNews, individualNews, message, status];
}
