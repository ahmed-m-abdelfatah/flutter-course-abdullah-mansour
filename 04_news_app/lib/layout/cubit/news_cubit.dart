import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../modules/business/business_screen.dart';
import '../../modules/science/science_screen.dart';
import '../../modules/sports/sports_screen.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/remote/dio_helper.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());

  // make an object from NewsCubit class
  static NewsCubit get(context) => BlocProvider.of(context);

  // start bottom nav bar items
  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomNavigationBarItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports_baseball), label: 'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
    // BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];

  void changeBottomNavigationBarItems(int index) {
    currentIndex = index;
    if (index == 1) getSports();
    if (index == 2) getScience();
    emit(NewsBottomNav());
  }

  // start body = list of screens
  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    // SettingsScreen(),
  ];

  // start add data from api
  List<dynamic> business = [];

  void getBusiness() {
    if (business.length == 0) {
      emit(NewsBusinessLoading());
      DioHelper.getData(
        path: pathUrl,
        query: businessQuery,
      ).then((value) {
        business = value.data['articles'];
        emit(NewsGetBusinessSucess());
      }).catchError((error) {
        emit(NewsGetBusinessError(error.toString()));
      });
    } else {
      emit(NewsGetBusinessSucess());
    }
  }

  List<dynamic> sports = [];

  void getSports() {
    if (sports.length == 0) {
      emit(NewsSportsLoading());
      DioHelper.getData(
        path: pathUrl,
        query: sportsQuery,
      ).then((value) {
        sports = value.data['articles'];
        emit(NewsGetSportsSucess());
      }).catchError((error) {
        emit(NewsGetSportsError(error.toString()));
      });
    } else {
      emit(NewsGetSportsSucess());
    }
  }

  List<dynamic> science = [];

  void getScience() {
    if (science.length == 0) {
      emit(NewsScienceLoading());
      DioHelper.getData(
        path: pathUrl,
        query: scienceQuery,
      ).then((value) {
        science = value.data['articles'];
        emit(NewsGetScienceSucess());
      }).catchError((error) {
        emit(NewsGetScienceError(error.toString()));
      });
    } else {
      emit(NewsGetScienceSucess());
    }
  }

  // start search
  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewsSearchLoading());
    DioHelper.getData(
      path: pathSearch,
      query: searchQuery(value),
    ).then((value) {
      search = value.data['articles'];
      emit(NewsGetSearchSucess());
    }).catchError((error) {
      emit(NewsGetSearchError(error.toString()));
    });
  }
}
