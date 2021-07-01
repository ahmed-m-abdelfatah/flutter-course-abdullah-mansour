import 'package:app02/Section4/bmi_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:app02/Section4/bmi_screen.dart';
import 'package:app02/Section3/Counter_Screen.dart';
import 'package:app02/Section3/MessengerScreen.dart';
import 'package:app02/Section3/Users_Screen.dart';
import 'package:app02/Section3/Login_Screen.dart';
import 'package:app02/Section3/MyHomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BmiScreen(),
    );
  }
}
