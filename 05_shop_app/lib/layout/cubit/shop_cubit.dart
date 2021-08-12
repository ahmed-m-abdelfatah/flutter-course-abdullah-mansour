import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../models/categories_model.dart';
import '../../models/change_favorites_model.dart';
import '../../models/favorites_model.dart';
import '../../models/login_model.dart';
import '../../models/home_model.dart';
import '../../modules/cateogries/cateogries_screen.dart';
import '../../modules/favorites/favorites_screen.dart';
import '../../modules/products/products_screen.dart';
import '../../modules/settings/settings_screen.dart';
import '../../shared/network/local/cache_data.dart';
import '../../shared/network/remote/dio_helper.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial());

  // object from ShopCubit
  static ShopCubit get(context) => BlocProvider.of(context);

  // start bottom nav bar items
  int currentIndex = 0;

  List<Widget> screens = [
    ProductsScreen(),
    CateogriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  List<BottomNavigationBarItem> bottomNavigationBarItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Cateogries'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];

  void changeBottomNavigationBarItems(int index) {
    currentIndex = index;
    emit(ChangeBottomNav());
  }

  // start get home data
  HomeModel? homeModel;

  void getHomeData() {
    emit(LoadingHomeData());

    DioHelper.getData(
      path: ApiDataAndEndPoints.homePathUrl,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      _addHomeDataToFavorites();
      emit(SuccessHomeData());
    }).catchError((error) {
      print('getHomeData -- ${error.toString()}');
      emit(ErrorHomeData(error.toString()));
    });
  }

  // start Add favorites data local
  Map<int, bool> favorites = {};

  void _addHomeDataToFavorites() {
    homeModel!.data.products.forEach((element) {
      favorites.addAll({
        element.id: element.inFavorites,
      });
    });
  }

  // start get favorites data
  FavoritesModel? favoritesModel;

  void getFavoritesData() {
    emit(LoadingFavoritesData());

    DioHelper.getData(
      path: ApiDataAndEndPoints.favoritesPathUrl,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(SuccessFavoritesData());
    }).catchError((error) {
      print("getFavoritesData -- ${error.toString()}");
      emit(ErrorFavoritesData(error.toString()));
    });
  }

  // start change favorites
  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId) async {
    try {
      favorites[productId] = !favorites[productId]!;
      emit(SuccessChangeFavoritesDataLocal());

      Response value = await DioHelper.postData(
        path: ApiDataAndEndPoints.favoritesPathUrl,
        data: {
          'product_id': productId,
        },
        token: token,
      );

      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (!changeFavoritesModel!.status) {
        // in case the status in remote == false
        // redo the change color in local
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavoritesData();
      }

      emit(SuccessChangeFavoritesDataRemote(changeFavoritesModel!));
    } catch (error) {
      favorites[productId] = !favorites[productId]!;
      print('changeFavorites -- ${error.toString()}');
      emit(ErrorChangeFavoritesDataRemote(error.toString()));
    }
  }

  // start get categories data
  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    emit(LoadingCategoriesData());

    DioHelper.getData(
      path: ApiDataAndEndPoints.getCategoriesPathUrl,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(SuccessCategoriesData());
    }).catchError((error) {
      print('getCategoriesData -- ${error.toString()}');
      emit(ErrorCategoriesData(error.toString()));
    });
  }

  // start get user data
  LoginModel? userModel;

  void getUserData() {
    emit(LoadingUserData());

    DioHelper.getData(
      path: ApiDataAndEndPoints.profilePathUrl,
      token: token,
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      emit(SuccessUserData(userModel!));
    }).catchError((error) {
      print('getUserData -- ${error.toString()}');
      emit(ErrorUserData(error.toString()));
    });
  }

  // start update user data
  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(LoadingUpdateUserData());

    DioHelper.putData(
      path: ApiDataAndEndPoints.updateProfilePathUrl,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      emit(SuccessUpdateUserData(userModel!));
    }).catchError((error) {
      print('updateUserData -- ${error.toString()}');
      emit(ErrorUpdateUserData(error.toString()));
    });
  }
}
