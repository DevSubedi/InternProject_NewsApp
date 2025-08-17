import 'package:dio/dio.dart';

import 'package:news_app/features/home/data/models/news_model.dart';

class NewsApiService {
  final Dio dio;
  NewsApiService(this.dio);

  Future<List<NewsModel>> getNewsService() async {
    try {
      final url =
          'https://newsapi.org/v2/top-headlines?country=us&apiKey=df767b84fbbe46f5b25e66b6eb533029';
      final response = await dio.get(
        url,
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final unlistedData = response.data['articles'] as List<dynamic>;
        List<NewsModel> data = unlistedData
            .map((e) => NewsModel.fromJson(e))
            .toList();
        return data;
      }
    } catch (e) {
      print('Error during the fetching the data: $e ');
    }
    return [];
  }

  Future<List<NewsModel>> categoryNewsService({
    String? category,
    int page = 1,
    int pageSize = 10,
    String country = 'us',
  }) async {
    const url = 'https://newsapi.org/v2/top-headlines';
    try {
      final params = <String, dynamic>{
        'country': country,
        'page': page,
        'pageSize': pageSize,
        'apiKey': 'df767b84fbbe46f5b25e66b6eb533029',
      };

      if (category != null && category.toLowerCase() != 'all') {
        params['category'] = category.toLowerCase();
      }

      final response = await dio.get(
        url,
        queryParameters: params,
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final list = (response.data['articles'] as List?) ?? [];
        return list.map((e) => NewsModel.fromJson(e)).toList();
      } else {
        throw Exception(
          'Status: ${response.statusCode}, Body: ${response.data}',
        );
      }
    } catch (e) {
      print('Error during the fetching the category-wise list: $e');
      return [];
    }
  }
}
