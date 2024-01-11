import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/Board/comment/comment.dart';
import 'package:flutterproject/Board/geul/geul_title_and_content.dart';
import 'package:flutterproject/Board/comment/new_comment.dart';
import 'package:flutterproject/Board/geul/new_or_edit_geul.dart';
import 'package:flutterproject/Board/palette.dart';
import 'package:flutterproject/screens/chatting_screen.dart';
import 'package:flutterproject/widgets/login_alarm_widget.dart';

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
  final user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.title;
    widget.content;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.board == 'freeBoard' ? '자유 게시판' : 'HOT 게시판',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Palette.color1,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<int>(
            elevation: 2,
            color: Palette.color1.withOpacity(0.7),
            iconColor: Colors.white,
            onSelected: (value) {
              if (value == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewOrEditGeul(
                          board: widget.board,
                          content: widget.content,
                          title: widget.title,
                          docId: widget.docId,
                          isEdit: true)),
                );
              } else if (value == 1) {
                if (user != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Chatting(
                              yourId: widget.userId,
                              yourName: widget.userName,
                            )),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginAlarm()),
                  );
                }
              }
            },
            offset: const Offset(-10, 52),
            itemBuilder: (context) {
              return [
                widget.userId == user?.uid
                    ? const PopupMenuItem(
                        value: 0,
                        child: Center(
                          child: Text(
                            '수정하기',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    : const PopupMenuItem(
                        value: 1,
                        child: Center(
                          child: Text(
                            '채팅하기',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
              ];
            },
          ),
          const SizedBox(
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
              NewComment(
                board: widget.board,
                docId: widget.docId,
                isRecomment: false,
                commentDocId: 'Idontcare',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
