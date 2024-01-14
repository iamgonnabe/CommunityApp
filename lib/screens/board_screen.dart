import 'package:flutter/material.dart';
import 'package:flutterproject/screens/free_board_screen.dart';
import 'package:flutterproject/widgets/hot_board_widget.dart';
import 'package:flutterproject/screens/review_board.screen.dart';

class BoardList extends StatelessWidget {
  const BoardList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            SizedBox(
              height: 100,
            ),
            GoToBoard(board: 'HOT', boardWidget: HotBoard()),
            SizedBox(
              height: 30,
            ),
            GoToBoard(board: '자유', boardWidget: FreeBoard()),
            SizedBox(
              height: 30,
            ),
            GoToBoard(board: '리뷰', boardWidget: ReviewBoard()),
          ],
        ),
      ],
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
          backgroundColor: Color(0xffFFD000),
        ),
      ),
    );
  }
}
