import 'package:news_app/features/home/data/models/news_model.dart';

abstract class NewsRepository {
  Future<List<NewsModel>> getTopHeadLines();
  Future<List<NewsModel>> getCategoryNews({
    String? category,
    int page,
    int pageSize,
    String country,
  });
}
