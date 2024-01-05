import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
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
                width: 200,
                child: const Text(
                  '깔삼한 로고',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const GoToBoards(board: 'HOT', boardList: HotBoard()),
            Container(
              color: Colors.grey,
              width: 300,
              height: 150,
            ),
            const SizedBox(
              height: 25,
            ),
            const GoToBoards(board: '자유', boardList: FreeBoard()),
            Container(
              padding: const EdgeInsets.all(6),
              width: 300,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey,
              ),
              child: const BoardsPreview(
                board: 'freeBoard',
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const GoToBoards(board: '리뷰', boardList: ReviewBoard()),
            Container(
              color: Colors.grey,
              width: 300,
              height: 150,
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
