part of 'ai_summary_bloc.dart';

@immutable
sealed class AiSummaryEvent {}

class GetContentEvent extends AiSummaryEvent {
  final String url;
  GetContentEvent({required this.url});
}

class GetSummaryEvent extends AiSummaryEvent {
  final String content;
  GetSummaryEvent({required this.content});
}
