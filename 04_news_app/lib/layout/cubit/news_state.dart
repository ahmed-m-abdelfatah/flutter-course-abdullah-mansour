part of 'news_cubit.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsBottomNav extends NewsState {}

class NewsBusinessLoading extends NewsState {}

class NewsGetBusinessSucess extends NewsState {}

class NewsGetBusinessError extends NewsState {
  final String error;
  NewsGetBusinessError(this.error);
}

class NewsSportsLoading extends NewsState {}

class NewsGetSportsSucess extends NewsState {}

class NewsGetSportsError extends NewsState {
  final String error;
  NewsGetSportsError(this.error);
}

class NewsScienceLoading extends NewsState {}

class NewsGetScienceSucess extends NewsState {}

class NewsGetScienceError extends NewsState {
  final String error;
  NewsGetScienceError(this.error);
}

class NewsSearchLoading extends NewsState {}

class NewsGetSearchSucess extends NewsState {}

class NewsGetSearchError extends NewsState {
  final String error;
  NewsGetSearchError(this.error);
}
