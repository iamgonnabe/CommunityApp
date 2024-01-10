import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/Board/palette.dart';
import 'package:flutterproject/screens/board_screen.dart';
import 'package:flutterproject/screens/chat_screen.dart';
import 'package:flutterproject/widgets/home_widget.dart';
import 'package:flutterproject/widgets/login_alarm_widget.dart';
import 'package:flutterproject/widgets/login_widget.dart';

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
  var user = FirebaseAuth.instance.currentUser;
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
        foregroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
              )),
        ],
        title: _selectedIndex == 2
            ? Text(
                user?.displayName ?? '',
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
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: const Icon(
                Icons.account_circle_rounded,
                size: 75,
                color: Colors.white70,
              ),
              accountName: hasLogin
                  ? Text(
                      user?.displayName ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    )
                  : null,
              accountEmail: hasLogin
                  ? Text(
                      user?.email ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    )
                  : null,
              decoration: const BoxDecoration(
                color: Palette.color1,
              ),
              onDetailsPressed: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.account_box_rounded,
                color: Palette.color4,
              ),
              title: hasLogin
                  ? const Text(
                      '로그아웃',
                      style: TextStyle(color: Colors.black),
                    )
                  : const Text(
                      '로그인',
                      style: TextStyle(color: Colors.black),
                    ),
              trailing: const Icon(Icons.navigate_next),
              onTap: () {
                if (user != null) {
                  FirebaseAuth.instance.signOut();
                  setState(() {
                    user == null;
                    hasLogin = false;
                  });
                } else {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                }
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
                color: Palette.color4,
              ),
              title: const Text('설정'),
              trailing: const Icon(Icons.navigate_next),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.bookmark_rounded,
                color: Palette.color4,
              ),
              title: const Text('개발자의 말'),
              trailing: const Icon(Icons.navigate_next),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text(
                          '아 못해 먹겠네',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // AlertDialog 닫기
                            },
                            child: const Text('닫기'),
                          ),
                        ],
                      );
                    });
              },
            ),
          ],
        ),
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
