import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'layout/cubit/shop_cubit.dart';

import 'layout/home_layout_screen.dart';
import 'modules/login/login_screen.dart';
import 'modules/on_boarding/on_boarding_screen.dart';
import 'modules/register/register_screen.dart';
import 'modules/search/search_screen.dart';
import 'shared/network/local/cache_data.dart';

class AppRouter {
  static const String startScreen = '/';
  static const String onBoardingScreen = '/boarding';
  static const String loginScreen = '/login';
  static const String registerScreen = '/register';
  static const String homeLayoutScreen = '/home';
  static const String searchScreen = '/search';

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case startScreen:
        return _startScreen();
      case onBoardingScreen:
        return _goToOnBoardingScreen();
      case loginScreen:
        return _goToLoginScreen();
      case registerScreen:
        return _goToRegisterScreen();
      case homeLayoutScreen:
        return _goToHomeLayoutScreen();
      case searchScreen:
        return _goToSearchScreen();
      default:
        return _startScreen();
    }
  }

  MaterialPageRoute<dynamic> _startScreen() {
    if (onBoarding != null) {
      // onBoarding = true
      if (token != null) {
        return _goToHomeLayoutScreen();
      } else {
        return _goToLoginScreen();
      }
    } else {
      return _goToOnBoardingScreen();
    }
  }

  MaterialPageRoute<dynamic> _goToOnBoardingScreen() {
    return MaterialPageRoute(
      builder: (_) => OnBoardingScreen(),
    );
  }

  MaterialPageRoute<dynamic> _goToLoginScreen() {
    return MaterialPageRoute(
      builder: (_) => LoginScreen(),
    );
  }

  MaterialPageRoute<dynamic> _goToRegisterScreen() {
    return MaterialPageRoute(
      builder: (_) => RegisterScreen(),
    );
  }

  MaterialPageRoute<dynamic> _goToHomeLayoutScreen() {
    return MaterialPageRoute(
      builder: (_) => BlocProvider(
        create: (_) => ShopCubit()
          ..getHomeData()
          ..getCategoriesData()
          ..getFavoritesData()
          ..getUserData(),
        child: HomeLayoutScreen(),
      ),
    );
  }

  MaterialPageRoute<dynamic> _goToSearchScreen() {
    return MaterialPageRoute(
      builder: (_) => SearchScreen(),
    );
  }
}
