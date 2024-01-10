import 'package:flutter/material.dart';
import 'package:flutterproject/Board/geul/each_geul_screen.dart';

class GeulPreview extends StatelessWidget {
  final String board;
  final String title;
  final String content;
  final String userName;
  final String time;
  final String docId;
  final String userId;
  final int comments;
  final int likes;
  const GeulPreview({
    super.key,
    required this.board,
    required this.title,
    required this.content,
    required this.userName,
    required this.time,
    required this.docId,
    required this.userId,
    required this.comments,
    required this.likes,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EachGeul(
                      board: board,
                      title: title,
                      content: content,
                      time: time,
                      userName: userName,
                      docId: docId,
                      userId: userId,
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
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                const Icon(
                  Icons.favorite_outline_rounded,
                  size: 13,
                  color: Colors.red,
                ),
                Text(
                  '${likes.toString()} ',
                  style: const TextStyle(color: Colors.red),
                ),
                const Icon(
                  Icons.chat_bubble_outline_rounded,
                  size: 13,
                  color: Colors.blueGrey,
                ),
                Text(
                  comments.toString(),
                  style: const TextStyle(color: Colors.blueGrey),
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
