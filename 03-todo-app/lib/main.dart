import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/layout/home_screen.dart';
import 'package:to_do_app/modules/counter_screen/counter_screen.dart';
import 'package:to_do_app/shared/block_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
