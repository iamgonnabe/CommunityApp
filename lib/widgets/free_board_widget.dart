import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/Board/geul.dart';
import 'package:flutterproject/Board/new_geul.dart';
import 'package:flutterproject/widgets/login_widget.dart';

class FreeBoard extends StatefulWidget {
  const FreeBoard({super.key});

  @override
  State<FreeBoard> createState() => _FreeBoardState();
}

class _FreeBoardState extends State<FreeBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('자유게시판'),
      ),
      body: Stack(
        children: [
          Container(
            child: const Column(children: [
              SizedBox(
                height: 20,
              ),
              Expanded(
                  child: Geul(
                board: 'freeBoard',
              )),
            ]),
          ),
          Positioned(
            right: 135,
            left: 135,
            bottom: 50,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StreamBuilder(
                          stream: FirebaseAuth.instance.authStateChanges(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return const NewGeul(
                                board: 'freeBoard',
                              );
                            }
                            return const Login();
                          },
                        ),
                      ));
                },
                child: const Text('글쓰기')),
          ),
        ],
      ),
    );
  }
}
