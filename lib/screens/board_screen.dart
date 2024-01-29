import 'package:flutter/material.dart';
import 'package:flutterproject/screens/free_board_screen.dart';
import 'package:flutterproject/screens/hot_board_screen.dart';
import 'package:flutterproject/screens/review_board.screen.dart';

class BoardList extends StatelessWidget {
  const BoardList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          Divider(
            height: 3,
            thickness: 3,
            color: Colors.black,
          ),
          SizedBox(
            height: 15,
          ),
          GoToBoard(board: 'HOT', boardWidget: HotBoard()),
          SizedBox(
            height: 15,
          ),
          Divider(
            height: 3,
            thickness: 3,
            color: Colors.black,
          ),
          SizedBox(
            height: 15,
          ),
          GoToBoard(board: '자유', boardWidget: FreeBoard()),
          SizedBox(
            height: 15,
          ),
          Divider(
            height: 3,
            thickness: 3,
            color: Colors.black,
          ),
          SizedBox(
            height: 15,
          ),
          GoToBoard(board: '리뷰', boardWidget: ReviewBoard()),
          SizedBox(
            height: 15,
          ),
          Divider(
            height: 3,
            thickness: 3,
            color: Colors.black,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            '...',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Divider(
            height: 3,
            thickness: 3,
            color: Colors.black,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            '...',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Divider(
            height: 3,
            thickness: 3,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}

class GoToBoard extends StatelessWidget {
  final String board;
  final Widget boardWidget;
  const GoToBoard({
    super.key,
    required this.board,
    required this.boardWidget,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => boardWidget),
        );
      },
      child: Text(
        '$board 게시판',
        style: const TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
