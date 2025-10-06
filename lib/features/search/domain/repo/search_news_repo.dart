import 'package:dartz/dartz.dart';
import 'package:news_app/features/home/data/models/news_model.dart';

abstract class SearchNewsRepo {
  Future<Either<String, List<NewsModel>>> fetchSearchedNews({
    required String query,
    required int page,
  });
}
