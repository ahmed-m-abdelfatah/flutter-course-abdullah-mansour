part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class LoadingSearchData extends SearchState {}

class SuccessSearchData extends SearchState {}

class ErrorSearchData extends SearchState {
  final String error;

  ErrorSearchData(this.error);
}
