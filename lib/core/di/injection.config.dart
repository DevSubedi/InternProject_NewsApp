// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:news_app/features/ai/data/repo/ai_repository_impl.dart'
    as _i864;
import 'package:news_app/features/ai/domain/repo/ai_repository.dart' as _i754;
import 'package:news_app/features/ai/presentation/bloc/ai_summary_bloc.dart'
    as _i950;
import 'package:news_app/features/search/data/repo/search_news_repo_impl.dart'
    as _i714;
import 'package:news_app/features/search/domain/repo/search_news_repo.dart'
    as _i430;
import 'package:news_app/features/search/presentation/bloc/search_bloc.dart'
    as _i74;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i754.AiRepository>(
        () => _i864.AiRepositoryImpl(gh<_i361.Dio>()));
    gh.lazySingleton<_i430.SearchNewsRepo>(
        () => _i714.SearchNewsRepoImpl(gh<_i361.Dio>()));
    gh.factory<_i74.SearchBloc>(
        () => _i74.SearchBloc(gh<_i430.SearchNewsRepo>()));
    gh.factory<_i950.AiSummaryBloc>(
        () => _i950.AiSummaryBloc(gh<_i754.AiRepository>()));
    return this;
  }
}
