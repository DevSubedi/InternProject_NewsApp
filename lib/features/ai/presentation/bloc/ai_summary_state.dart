part of 'ai_summary_bloc.dart';

enum AiSummaryStatus { initial, loading, loaded, error }

class AiSummaryState extends Equatable {
  final AiSummaryStatus status;
  final String content;
  final String summary;
  const AiSummaryState({
    this.content = '',
    this.summary = '',
    this.status = AiSummaryStatus.initial,
  });

  AiSummaryState copyWith({
    String? content,
    String? summary,
    AiSummaryStatus? status,
  }) {
    return AiSummaryState(
      status: status ?? this.status,
      content: content ?? this.content,
      summary: summary ?? this.summary,
    );
  }

  @override
  List<Object?> get props => [content, summary, status];
}
