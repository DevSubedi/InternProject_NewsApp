part of 'news_bloc.dart';

sealed class NewsEvent extends Equatable {}

class FetchAllNewsEvent extends NewsEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
