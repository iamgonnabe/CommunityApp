import 'package:flutter/material.dart';
import 'package:flutterproject/Board/palette.dart';
import 'package:flutterproject/widgets/boards_preview.dart';
import 'package:flutterproject/widgets/go_to_boards.dart';
import 'package:flutterproject/screens/free_board_screen.dart';
import 'package:flutterproject/screens/hot_board_screen.dart';

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
                width: 300,
                height: 50,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Palette.color7,
                      Palette.color1,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Text(
                  'Welcome',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
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
          ],
        ),
      ),
    );
  }
}
