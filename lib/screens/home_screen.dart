import 'package:flutter/material.dart';
import 'package:flutterproject/widgets/board_list_widget.dart';
import 'package:flutterproject/widgets/chatting_widget.dart';
import 'package:flutterproject/widgets/home_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const BoardList(),
    const Chatting(),
  ];
  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFF7B00),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Color(0xffFFEA00),
              )),
          IconButton(
              padding: const EdgeInsets.only(right: 35, left: 10),
              onPressed: () {},
              icon: const Icon(
                Icons.account_circle,
                color: Color(0xffFFEA00),
              )),
        ],
        leading: const Icon(
          Icons.star,
          color: Colors.white,
        ),
      ),
      body: SafeArea(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.toc), label: '게시판'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: '채팅'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xffFFEA00),
        onTap: _onItemTapped,
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
