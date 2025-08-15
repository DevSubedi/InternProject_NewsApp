import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/features/home/data/data_source/date_time_service.dart';
import 'package:news_app/features/home/data/data_source/news_api_service.dart';

final sl = GetIt.instance;
void setupLocator() {
  //for external classes
  sl.registerLazySingleton<Dio>(() => Dio());

  //for internal / self built classes

  sl.registerLazySingleton<NewsApiService>(() => NewsApiService(sl()));

  sl.registerLazySingleton<DateTimeService>(() => DateTimeService());
}
