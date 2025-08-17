part of 'news_bloc.dart';

sealed class NewsEvent {}

class FetchAllNewsEvent extends NewsEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class FetchCategoryNewsEvent extends NewsEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class SelectCategoryEvent extends NewsEvent {
  String selectedCategoryEvent;
  SelectCategoryEvent({required this.selectedCategoryEvent});
}
