import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:news_app/features/ai/domain/repo/ai_repository.dart';

part 'ai_summary_event.dart';
part 'ai_summary_state.dart';

@Injectable()
class AiSummaryBloc extends Bloc<AiSummaryEvent, AiSummaryState> {
  final AiRepository repo;
  AiSummaryBloc(this.repo) : super(AiSummaryState()) {
    on<GetContentEvent>(_onGetContentEvent);
    on<GetSummaryEvent>(_onGetSummaryEvent);
  }

  FutureOr<void> _onGetContentEvent(
    GetContentEvent event,
    Emitter<AiSummaryState> emit,
  ) async {
    try {
      final content = await repo.getNewsContent(url: event.url);
      emit(state.copyWith(content: content));

      log(content);
    } catch (e) {
      log('Error during parsing or no data $e');
    }
  }

  FutureOr<void> _onGetSummaryEvent(
    GetSummaryEvent event,
    Emitter<AiSummaryState> emit,
  ) async {
    emit(state.copyWith(status: AiSummaryStatus.loading));
    try {
      final result = await repo.getAiSummary(content: state.content);
      emit(state.copyWith(status: AiSummaryStatus.loaded, summary: result));
    } catch (e) {
      emit(state.copyWith(status: AiSummaryStatus.error));
    }
  }
}
