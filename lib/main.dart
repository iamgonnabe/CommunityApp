import 'package:flutter/material.dart';
import 'package:flutterproject/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: const Color(0xffFF7B00),
          fontFamily: 'Georgia',
          textTheme: const TextTheme(
            labelLarge: TextStyle(
                color: Color(0xffFFB700),
                fontWeight: FontWeight.w600,
                fontSize: 25),
            labelMedium: TextStyle(
                color: Color(0xffFFD000),
                fontWeight: FontWeight.w400,
                fontSize: 20),
            labelSmall: TextStyle(
                color: Color(0xffFFEA00),
                fontWeight: FontWeight.w200,
                fontSize: 18),
          ),
        ),
        home: const HomeScreen());
  }
}
