import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../shared/network/local/cache_helper.dart';

part 'app_theme_mode_state.dart';

class AppThemeMode extends Cubit<AppState> {
  AppThemeMode() : super(AppInitial());

  // make an object from AppCubit class
  static AppThemeMode get(context) => BlocProvider.of(context);

  bool isDark = false;

  void changeAppMode({bool? isDarkFromShared}) {
    if (isDarkFromShared != null) {
      isDark = isDarkFromShared;
      emit(ThemeChangeMode());
    } else {
      isDark = !isDark;
      CacheHelper.saveCacheData(key: 'isDark', value: isDark).then(
        (_) => emit(ThemeChangeMode()),
      );
    }
  }

  void saveAppModeInFirstLaunch({bool? isDarkFromShared}) {
    if (isDarkFromShared != null) {
      isDark = isDarkFromShared;
      emit(ThemeLaunchMode());
    } else {
      CacheHelper.saveCacheData(key: 'isDark', value: isDark)
          .then((_) => emit(ThemeLaunchMode()));
    }
  }
}
