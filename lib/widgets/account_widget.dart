import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/widgets/login_widget.dart';

import '../Board/palette.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loggedUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              padding: const EdgeInsets.only(right: 35, left: 10),
              onPressed: () {
                _authentication.signOut();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ));
              },
              icon: const Icon(
                Icons.logout,
                color: Palette.color10,
              )),
        ],
      ),
      body: Container(),
    );
  }
}
