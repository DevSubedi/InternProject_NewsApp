part of 'news_bloc.dart';

enum DataStatus { intial, loading, loaded, error }

class NewsState extends Equatable {
  final DataStatus status;
  final List<NewsModel> allNews;
  final NewsModel individualNews;

  final String message;

  final List<NewsModel> categoryNews;
  final DataStatus categoryStatus;
  final String selectedCategory;
  final List<NewsModel> favoriteNewsList;
  final NewsModel favoriteNews;
  final bool showToastFavorite;

  const NewsState({
    this.allNews = const [],
    this.individualNews = NewsModel.emptyNewsModel,
    this.message = '',
    this.status = DataStatus.intial,
    this.categoryNews = const [],
    this.selectedCategory = '',
    this.favoriteNewsList = const [],
    this.favoriteNews = NewsModel.emptyNewsModel,
    this.categoryStatus = DataStatus.intial,
    this.showToastFavorite = false,
  });

  NewsState copyWith({
    DataStatus? status,
    List<NewsModel>? allNews,
    NewsModel? individualNews,
    String? message,
    List<NewsModel>? categoryNews,
    String? selectedCategory,
    List<NewsModel>? favoriteNewsList,
    NewsModel? favoriteNews,
    DataStatus? categoryStatus,
    bool? showToastFavorite,
  }) {
    return NewsState(
      status: status ?? this.status,
      allNews: allNews ?? this.allNews,
      message: message ?? this.message,
      individualNews: individualNews ?? this.individualNews,
      categoryNews: categoryNews ?? this.categoryNews,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      favoriteNewsList: favoriteNewsList ?? this.favoriteNewsList,
      favoriteNews: favoriteNews ?? this.favoriteNews,
      categoryStatus: categoryStatus ?? this.categoryStatus,
      showToastFavorite: showToastFavorite ?? this.showToastFavorite,
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
    categoryStatus,
    favoriteNews,
    favoriteNewsList,
    showToastFavorite,
  ];
}
