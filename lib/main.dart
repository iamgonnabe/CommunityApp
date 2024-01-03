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
      ),
      home: const HomeScreen(),
    );
  }
}
