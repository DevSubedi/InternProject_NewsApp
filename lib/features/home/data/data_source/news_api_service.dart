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
}
