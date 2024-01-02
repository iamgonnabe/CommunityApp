import 'package:flutter/material.dart';
import 'package:flutterproject/repository/palette.dart';
import 'package:flutterproject/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutterproject/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Palette.color1,
        fontFamily: 'Georgia',
        textTheme: const TextTheme(
          labelLarge: TextStyle(
              color: Palette.color6, fontWeight: FontWeight.w600, fontSize: 25),
          labelMedium: TextStyle(
              color: Palette.color8, fontWeight: FontWeight.w400, fontSize: 20),
          labelSmall: TextStyle(
              color: Palette.color10,
              fontWeight: FontWeight.w200,
              fontSize: 18),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
