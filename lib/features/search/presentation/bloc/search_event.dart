part of 'search_bloc.dart';

abstract class SearchEvent {}

class GetSearchTitleEvent extends SearchEvent {
  String searchTitle;
  GetSearchTitleEvent({required this.searchTitle});
}

class PerformSearchEvent extends SearchEvent {}

class PerformPaginationEvent extends SearchEvent {}
