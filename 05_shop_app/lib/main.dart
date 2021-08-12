import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_router.dart';
import 'layout/cubit/shop_cubit.dart';
import 'shared/network/local/cache_data.dart';
import 'shared/network/remote/dio_helper.dart';

import 'cubit/app_theme_mode_cubit.dart';
import 'shared/block_observer.dart';
import 'shared/network/local/cache_helper.dart';
import 'shared/styles/my_dark_theme.dart';
import 'shared/styles/my_light_theme.dart';

void main() async {
  // to ensure running all async await functions before runApp
  WidgetsFlutterBinding.ensureInitialized();

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Scaffold(
      body: Center(
        child: Text('Loading Data .. Come Later!'),
      ),
    );
  };

  Bloc.observer = MyBlocObserver();

  DioHelper.init();

  await CacheHelper.init();

  isDarkFromShared = CacheHelper.getCacheData(key: 'isDark');
  onBoarding = CacheHelper.getCacheData(key: 'onBoarding');
  token = CacheHelper.getCacheData(key: 'token');

  runApp(
    ShopApp(
      isDarkFromShared: isDarkFromShared,
      appRouter: AppRouter(),
    ),
  );
}

class ShopApp extends StatelessWidget {
  final bool? isDarkFromShared;
  final AppRouter appRouter;

  const ShopApp({
    Key? key,
    required this.isDarkFromShared,
    required this.appRouter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        _appThemeMode(),
        _shopCubit(),
      ],
      child: BlocConsumer<AppThemeMode, AppState>(
        listener: _listener,
        builder: _buildMaterialApp,
      ),
    );
  }

  BlocProvider<AppThemeMode> _appThemeMode() {
    return BlocProvider(
      create: (_) => AppThemeMode()
        ..saveAppModeInFirstLaunch(isDarkFromShared: isDarkFromShared),
    );
  }

  BlocProvider<ShopCubit> _shopCubit() {
    return BlocProvider(
      // get data where you provide the cubit
      create: (_) => ShopCubit()
        ..getHomeData()
        ..getCategoriesData()
        ..getFavoritesData()
        ..getUserData(),
    );
  }

  void _listener(context, state) {}

  MaterialApp _buildMaterialApp(BuildContext context, state) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode(context),
      theme: myLightTheme(context),
      darkTheme: myDarkTheme(context),
      onGenerateRoute: appRouter.generateRoute,
      onUnknownRoute: appRouter.generateRoute,
      // initialRoute: AppRouter.homeLayoutScreen,
    );
  }

  ThemeMode _themeMode(context) {
    return AppThemeMode.get(context).isDark ? ThemeMode.dark : ThemeMode.light;
  }
}
