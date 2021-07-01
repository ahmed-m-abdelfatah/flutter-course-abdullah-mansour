import 'package:app02/Counter_Screen.dart';
import 'package:app02/MessengerScreen.dart';
import 'package:app02/Users_Screen.dart';
import 'package:flutter/material.dart';
import 'package:app02/Login_Screen.dart';
import 'package:app02/MyHomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CounterScreen(),
    );
  }
}
