import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../shared/network/local/cache_helper.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  // make an object from AppCubit class
  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void changeAppMode({bool? isDarkFromShared}) {
    if (isDarkFromShared != null) {
      isDark = isDarkFromShared;
      emit(ChangeMode());
    } else {
      isDark = !isDark;
      CacheHelper.setBoolData(key: 'isDark', value: isDark).then(
        (value) {
          emit(ChangeMode());
        },
      );
    }
  }
}
