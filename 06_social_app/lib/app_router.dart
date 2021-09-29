import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'layout/cubit/social_cubit.dart';
import 'layout/home_layout.dart';
import 'modules/chat_details/chat_details_screen.dart';
import 'modules/edit_profile/edit_profile_screen.dart';
import 'modules/login/cubit/login_cubit.dart';
import 'modules/login/login_screen.dart';
import 'modules/new_post/new_post_screen.dart';
import 'modules/register/cubit/register_cubit.dart';
import 'modules/register/register_screen.dart';
import 'shared/network/local/cache_data.dart';

class AppRouter {
  static const String startScreen = '/';
  static const String newPostScreen = '/new-post';
  static const String loginScreen = '/login';
  static const String registerScreen = '/register';
  static const String homeLayoutScreen = '/home';
  static const String editProfileScreen = '/edit-Profile';
  static const String chatDetailsScreen = '/chat-details';

  static SocialCubit _socialCubit = SocialCubit();
  void dispose() {
    _socialCubit.close();
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case startScreen:
        return _startScreen();
      case newPostScreen:
        return _goToNewPostScreen();
      case loginScreen:
        return _goToLoginScreen();
      case registerScreen:
        return _goToRegisterScreen();
      case homeLayoutScreen:
        return _goToHomeLayoutScreen();
      case editProfileScreen:
        return _goToEditProfileScreen();
      case chatDetailsScreen:
        return _goToChatDetailsScreen(settings);
      default:
        return _startScreen();
    }
  }

  static MaterialPageRoute<dynamic>? _startScreen() {
    if (CacheData.uId != null) {
      return _goToHomeLayoutScreen();
    } else {
      return _goToLoginScreen();
    }
  }

  static MaterialPageRoute<dynamic> _goToNewPostScreen() {
    return MaterialPageRoute(
      builder: (_) => BlocProvider.value(
        value: _socialCubit,
        child: NewPostScreen(),
      ),
    );
  }

  static MaterialPageRoute<dynamic> _goToLoginScreen() {
    return MaterialPageRoute(
      builder: (_) => BlocProvider(
        create: (context) => LoginCubit(),
        child: LoginScreen(),
      ),
    );
  }

  static MaterialPageRoute<dynamic> _goToRegisterScreen() {
    return MaterialPageRoute(
      builder: (_) => BlocProvider(
        create: (context) => RegisterCubit(),
        child: RegisterScreen(),
      ),
    );
  }

  static MaterialPageRoute<dynamic> _goToHomeLayoutScreen() {
    return MaterialPageRoute(
      builder: (_) => BlocProvider.value(
        value: _socialCubit
          ..getCurrentUserData()
          ..getPostsData(),
        child: HomeLayoutScreen(),
      ),
    );
  }

  static MaterialPageRoute<dynamic> _goToEditProfileScreen() {
    return MaterialPageRoute(
      builder: (_) => BlocProvider.value(
        value: _socialCubit,
        child: EditProfileScreen(),
      ),
    );
  }

  static MaterialPageRoute<dynamic> _goToChatDetailsScreen(settings) {
    final chatUser = settings.arguments;

    return MaterialPageRoute(
      builder: (_) => BlocProvider.value(
        value: _socialCubit,
        child: ChatDetailsScreen(
          chatUser: chatUser,
        ),
      ),
    );
  }
}
