import 'package:flutter/material.dart';
import 'package:flutterproject/Board/goto_each_geul.dart';
import 'package:flutterproject/Board/palette.dart';

class GeulByBoards extends StatelessWidget {
  final String title;
  final String content;
  final String userName;
  final String time;
  const GeulByBoards(
      {super.key,
      required this.title,
      required this.content,
      required this.userName,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GotoEachGeul(
                      title: title,
                      content: content,
                      time: time,
                      userName: userName,
                    )));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            Row(
              children: [
                const Text(
                  '댓글 ',
                  style: TextStyle(color: Colors.grey),
                ),
                const Text('|', style: TextStyle(color: Colors.grey)),
                Text(' $time ', style: const TextStyle(color: Colors.grey)),
                const Text('|', style: TextStyle(color: Colors.grey)),
                Text(' $userName', style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}