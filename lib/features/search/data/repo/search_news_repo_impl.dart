import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:injectable/injectable.dart';
import 'package:news_app/features/home/data/models/news_model.dart';
import 'package:news_app/features/search/domain/repo/search_news_repo.dart';

@LazySingleton(as: SearchNewsRepo)
class SearchNewsRepoImpl implements SearchNewsRepo {
  final Dio dio;
  SearchNewsRepoImpl(this.dio);
  @override
  Future<Either<String, List<NewsModel>>> fetchSearchedNews({
    required String query,
    required int page,
  }) async {
    String url = 'https://newsapi.org/v2/everything';
    try {
      final response = await dio.get(
        url,
        queryParameters: {
          'q': query,
          'page': page,
          'pageSize': 10,
          // 'sortBy': 'publishedAt',
          'apiKey': 'df767b84fbbe46f5b25e66b6eb533029',
        },
      );
      final data = response.data["articles"] as List;
      List<NewsModel> news = data.map((e) => NewsModel.fromJson(e)).toList();
      return Right(news);
    } catch (e) {
      log(e.toString());
      return Left('Error during fetching search item: ${e.toString()}');
    }
  }
}
