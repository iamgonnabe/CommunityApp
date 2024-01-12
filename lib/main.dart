import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/Board/palette.dart';
import 'package:flutterproject/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutterproject/firebase_options.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppUser(user: null),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              ForRecomment(commentDocId: '', isRecomment: false),
        ),
      ],
      child: GetMaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Palette.color1,
          fontFamily: 'Georgia',
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

class AppUser with ChangeNotifier {
  User? _user;

  AppUser({required User? user}) : _user = user;

  User? get user => _user;

  void login() {
    _user = FirebaseAuth.instance.currentUser;
    notifyListeners();
  }

  void logout() {
    FirebaseAuth.instance.signOut();
    _user = null;
    notifyListeners();
  }
}

class ForRecomment with ChangeNotifier {
  String commentDocId;
  bool isRecomment;
  ForRecomment({
    required this.commentDocId,
    required this.isRecomment,
  });
  void update(String a, bool b) {
    commentDocId = a;
    isRecomment = b;
    notifyListeners();
  }
}
