import 'package:flutter/material.dart';

class BoardsPreview extends StatelessWidget {
  final String board;
  final Widget boardList;
  const BoardsPreview(
      {super.key, required this.board, required this.boardList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => boardList),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('$board 게시판'),
            const Row(
              children: [
                Text('더보기'),
                Icon(Icons.chevron_right),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
