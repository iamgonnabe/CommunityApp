import 'package:flutter/material.dart';
import 'package:flutterproject/Board/comment.dart';
import 'package:flutterproject/Board/geul_title_and_content.dart';
import 'package:flutterproject/Board/new_comment.dart';
import 'package:flutterproject/Board/palette.dart';

class EachGeul extends StatefulWidget {
  final String board;
  final String title;
  final String content;
  final String time;
  final String userName;
  final String docId;
  final String userId;
  const EachGeul({
    super.key,
    required this.board,
    required this.title,
    required this.content,
    required this.time,
    required this.userName,
    required this.docId,
    required this.userId,
  });

  @override
  State<EachGeul> createState() => _EachGeulState();
}

class _EachGeulState extends State<EachGeul> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '자유 게시판',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Palette.color1,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.chevron_left),
          color: Colors.white,
          iconSize: 40,
        ),
        actions: const [
          Icon(
            Icons.edit,
            color: Colors.white,
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleAndContent(
                board: widget.board,
                docId: widget.docId,
                title: widget.title,
                content: widget.content,
                time: widget.time,
                userName: widget.userName,
                userId: widget.userId,
              ),
              Comments(
                board: widget.board,
                docId: widget.docId,
                title: widget.title,
                content: widget.content,
                time: widget.time,
                userName: widget.userName,
              ),
              NewComment(board: widget.board, docId: widget.docId),
            ],
          ),
        ),
      ),
    );
  }
}
