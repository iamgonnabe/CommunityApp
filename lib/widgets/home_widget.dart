import 'package:flutter/material.dart';
import 'package:flutterproject/widgets/boards_preview.dart';
import 'package:flutterproject/widgets/go_to_boards.dart';
import 'package:flutterproject/widgets/free_board_widget.dart';
import 'package:flutterproject/widgets/hot_board_widget.dart';
import 'package:flutterproject/widgets/review_board.widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Center(
              child: Container(
                color: Colors.grey,
                width: 300,
                height: 50,
                child: const Text(
                  '광고 배너',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const GoToBoards(board: 'HOT', boardList: HotBoard()),
            const BoardsPreview(
              board: 'hotBoard',
            ),
            const SizedBox(
              height: 30,
            ),
            const GoToBoards(board: '자유', boardList: FreeBoard()),
            const BoardsPreview(
              board: 'freeBoard',
            ),
            const SizedBox(
              height: 30,
            ),
            const GoToBoards(board: '리뷰', boardList: ReviewBoard()),
            const BoardsPreview(
              board: 'freeBoard',
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
