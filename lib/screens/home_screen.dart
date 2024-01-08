import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/Board/palette.dart';
import 'package:flutterproject/screens/board_screen.dart';
import 'package:flutterproject/screens/chat_screen.dart';
import 'package:flutterproject/widgets/home_widget.dart';
import 'package:flutterproject/widgets/login_alarm_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  // final List<Widget> _widgetOptions = <Widget>[
  //   const HomePage(),
  //   const BoardList(),
  //   hasLogin ? const Chatting() : const LoginAlarm(),
  // ];
  final user = FirebaseAuth.instance.currentUser;
  get userName => user?.displayName;
  bool hasLogin = false;

  void isLogin() {
    FirebaseAuth.instance.userChanges().listen((User? user) {
      setState(() {
        hasLogin = user != null;
      });
    });
  }

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    isLogin();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      const HomePage(),
      const BoardList(),
      hasLogin ? const Chat() : const LoginAlarm(),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.color1,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              )),
        ],
        leading: const Icon(
          Icons.star,
          color: Colors.white,
        ),
        title: _selectedIndex == 2
            ? Text(
                userName,
                style: const TextStyle(color: Colors.white),
              )
            : null,
      ),
      body: SafeArea(child: widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.toc), label: '게시판'),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: '채팅',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Palette.color1,
        onTap: _onItemTapped,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
