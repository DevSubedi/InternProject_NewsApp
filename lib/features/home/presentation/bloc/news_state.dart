part of 'news_bloc.dart';

enum DataStatus { intial, loading, loaded, error }

class NewsState extends Equatable {
  final DataStatus status;
  final List<NewsModel> allNews;
  final NewsModel individualNews;

  final String message;

  final List<NewsModel> categoryNews;
  final String selectedCategory;

  const NewsState({
    this.allNews = const [],
    this.individualNews = NewsModel.emptyNewsModel,
    this.message = '',
    this.status = DataStatus.intial,
    this.categoryNews = const [],
    this.selectedCategory = '',
  });

  NewsState copyWith({
    DataStatus? status,
    List<NewsModel>? allNews,
    NewsModel? individualNews,
    String? message,
    List<NewsModel>? categoryNews,
    String? selectedCategory,
  }) {
    return NewsState(
      status: status ?? this.status,
      allNews: allNews ?? this.allNews,
      message: message ?? this.message,
      individualNews: individualNews ?? this.individualNews,
      categoryNews: categoryNews ?? this.categoryNews,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    allNews,
    individualNews,
    message,
    status,
    selectedCategory,
    categoryNews,
  ];
}
