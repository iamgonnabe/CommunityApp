import 'package:flutter/material.dart';
import 'package:flutterproject/repository/geul.dart';

class FreeBoard extends StatelessWidget {
  const FreeBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('자유게시판'),
      ),
      body: const Column(children: [
        SizedBox(
          height: 20,
        ),
        Expanded(child: Geul())
      ]),
    );
  }
}
