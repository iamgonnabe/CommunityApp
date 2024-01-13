import 'package:flutter/material.dart';
import 'package:flutterproject/Board/geul/geul.dart';

class HotBoard extends StatelessWidget {
  const HotBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOT 게시판'),
      ),
      body: const Stack(
        children: [
          Column(children: [
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: Geul(
              board: 'hotBoard',
            )),
          ]),
        ],
      ),
    );
  }
}
