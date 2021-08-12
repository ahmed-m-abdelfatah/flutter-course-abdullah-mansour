part of 'shop_cubit.dart';

@immutable
abstract class ShopState {}

class ShopInitial extends ShopState {}

class ChangeBottomNav extends ShopState {}

class LoadingHomeData extends ShopState {}

class SuccessHomeData extends ShopState {}

class ErrorHomeData extends ShopState {
  final String error;

  ErrorHomeData(this.error);
}

class LoadingCategoriesData extends ShopState {}

class SuccessCategoriesData extends ShopState {}

class ErrorCategoriesData extends ShopState {
  final String error;

  ErrorCategoriesData(this.error);
}

class LoadingUserData extends ShopState {}

class SuccessUserData extends ShopState {
  final LoginModel userData;

  SuccessUserData(this.userData);
}

class ErrorUserData extends ShopState {
  final String error;

  ErrorUserData(this.error);
}

class LoadingUpdateUserData extends ShopState {}

class SuccessUpdateUserData extends ShopState {
  final LoginModel userData;

  SuccessUpdateUserData(this.userData);
}

class ErrorUpdateUserData extends ShopState {
  final String error;

  ErrorUpdateUserData(this.error);
}

class LoadingFavoritesData extends ShopState {}

class SuccessFavoritesData extends ShopState {}

class ErrorFavoritesData extends ShopState {
  final String error;

  ErrorFavoritesData(this.error);
}

class SuccessChangeFavoritesDataLocal extends ShopState {}

class SuccessChangeFavoritesDataRemote extends ShopState {
  final ChangeFavoritesModel changeFavoritesModel;

  SuccessChangeFavoritesDataRemote(this.changeFavoritesModel);
}

class ErrorChangeFavoritesDataRemote extends ShopState {
  final String error;

  ErrorChangeFavoritesDataRemote(this.error);
}
