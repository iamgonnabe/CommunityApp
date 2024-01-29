import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/Board/comment/comment.dart';
import 'package:flutterproject/Board/comment/new_recomment.dart';
import 'package:flutterproject/Board/geul/geul_title_and_content.dart';
import 'package:flutterproject/Board/comment/new_comment.dart';
import 'package:flutterproject/Board/geul/new_or_edit_geul.dart';
import 'package:flutterproject/Board/palette.dart';
import 'package:flutterproject/main.dart';
import 'package:flutterproject/screens/chatting_screen.dart';
import 'package:flutterproject/screens/free_board_screen.dart';
import 'package:flutterproject/screens/hot_board_screen.dart';
import 'package:flutterproject/widgets/login_alarm_widget.dart';
import 'package:provider/provider.dart';

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
  int likes = 0;
  @override
  void initState() {
    super.initState();
    widget.title;
    widget.content;
    get();
  }

  void get() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('freeBoard')
        .doc(widget.docId)
        .get();
    likes = await snapshot.get('likes');
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
                          content: widget.content,
                          title: widget.title,
                          docId: widget.docId,
                          isEdit: true)),
                );
              } else if (value == 1) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text(
                          '삭제 하시겠습니까?',
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () async {
                              await FirebaseFirestore.instance
                                  .collection('freeBoard')
                                  .doc(widget.docId)
                                  .delete();
                              if (!context.mounted) return;
                              if (widget.board == 'freeBoard') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const FreeBoard()),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HotBoard()),
                                );
                              }
                            },
                            child: const Text(
                              '삭제',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('취소'),
                          ),
                        ],
                      );
                    });
              } else if (value == 2) {
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
              if (widget.userId == user?.uid) {
                if (likes < 1) {
                  return [
                    const PopupMenuItem(
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
                    ),
                    const PopupMenuDivider(),
                    const PopupMenuItem(
                      value: 1,
                      child: Center(
                        child: Text(
                          '삭제하기',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ];
                } else {
                  return [
                    const PopupMenuItem(
                      value: 1,
                      child: Center(
                        child: Text(
                          '삭제하기',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ];
                }
              } else {
                return [
                  const PopupMenuItem(
                    value: 2,
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
              }
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
                docId: widget.docId,
                title: widget.title,
                content: widget.content,
                time: widget.time,
                userName: widget.userName,
                userId: widget.userId,
              ),
              Comments(
                board: 'freeBoard',
                docId: widget.docId,
                title: widget.title,
                content: widget.content,
                time: widget.time,
                userName: widget.userName,
              ),
              Provider.of<ForRecomment>(context).isRecomment
                  ? NewRecomment(board: 'freeBoard', docId: widget.docId)
                  : NewComment(
                      board: 'freeBoard',
                      docId: widget.docId,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
