import 'package:dio/dio.dart';

import 'package:news_app/features/home/data/models/news_model.dart';

class SearchApiService {
  final Dio dio;
  const SearchApiService(this.dio);

  Future<List<NewsModel>> searchApiMethod(String query) async {
    try {
      final response = await dio.get(
        "https://newsapi.org/v2/everything",
        queryParameters: {
          "q": query,
          "apiKey": "df767b84fbbe46f5b25e66b6eb533029",
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> searchedNews = response.data["articles"];
        final data = searchedNews.map((e) => NewsModel.fromJson(e)).toList();
        // // sort manually (descending order)
        // data.sort((a, b) {
        //   final dateA =
        //       DateTime.tryParse(a.publishedAt ?? '') ?? DateTime(1970);
        //   final dateB =
        //       DateTime.tryParse(b.publishedAt ?? '') ?? DateTime(1970);
        //   return dateB.compareTo(dateA); // latest first
        // });
        return data;
      }
    } catch (e) {
      print('Error during the fetching the data: $e');
    }
    return [];
  }
}
