import 'package:flutter/material.dart';
import '../../app_router.dart';
import '../network/local/cache_helper.dart';

void signOut(context) {
  CacheHelper.removeCacheData(key: 'token').then(
    (value) {
      if (value) {
        Navigator.pushReplacementNamed(context, AppRouter.loginScreen);
      }
    },
  );
}
