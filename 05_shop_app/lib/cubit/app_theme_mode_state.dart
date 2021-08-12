part of 'app_theme_mode_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class ThemeLaunchMode extends AppState {}

class ThemeChangeMode extends AppState {}
