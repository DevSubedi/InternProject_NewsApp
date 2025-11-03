import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:html/parser.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/features/ai/domain/repo/ai_repository.dart';

@LazySingleton(as: AiRepository)
class AiRepositoryImpl implements AiRepository {
  final Dio dio;
  AiRepositoryImpl(this.dio);
  @override
  Future getNewsContent({required String url}) async {
    try {
      ;
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final document = parse(response.data);

        final paragraphs = document.getElementsByTagName('p');
        String content = paragraphs.map((p) => p.text).join('\n\n');
        return content;
      } else {
        return 'Failed to load article';
      }
    } catch (e) {
      return 'Error $e';
    }
  }

  @override
  Future<String> getAiSummary({required String content}) async {
    final apiKey = dotenv.env['GEMINI_API_KEY'];

    final url =
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent";
    try {
      final response = await Dio().post(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'x-goog-api-key': apiKey,
          },
        ),
        data: {
          "contents": [
            {
              "parts": [
                {
                  "text":
                      "You are a helpful assistant that summarizes news articles clearly. Summarize this news article in 100 words:\n\n$content",
                },
              ],
            },
          ],
        },
      );

      log("✅ Gemini response: ${response.data}");

      final summary =
          response.data['candidates'][0]['content']['parts'][0]['text'];
      return summary.trim();
    } catch (e) {
      log('❌ Error during summary fetching: $e');
      return 'Error during summary fetching';
    }
  }

  // @override
  // Future<String> getAiSummary({required String content}) async {
  //   final apiKey = dotenv.env['OPENAI_API_KEY'];
  //   final url = 'https://api.openai.com/v1/chat/completions';

  //   try {
  //     final response = await dio.post(
  //       url,
  //       options: Options(
  //         headers: {
  //           'Authorization': 'Bearer $apiKey',
  //           'Content-Type': 'application/json',
  //         },
  //       ),
  //       data: {
  //         'model': "gpt-3.5-turbo",
  //         'messages': [
  //           {
  //             'role': 'system',
  //             "content":
  //                 "You are a helpful assistant that summarizes news articles clearly.",
  //           },
  //           {
  //             'role': 'user',
  //             'content':
  //                 'Summarise this news article in 100 words: \n\n$content',
  //           },
  //         ],
  //       },
  //     );

  //     final summary = response.data['choices'][0]['message']['content'];
  //     return summary.trim();
  //   } catch (e) {
  //     log('Error during summarising: $e');
  //     return 'Failed to summarise the article';
  //   }
  // }
}
