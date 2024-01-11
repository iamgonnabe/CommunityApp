import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/Board/comment/new_comment.dart';
import 'package:flutterproject/Board/palette.dart';
import 'package:flutterproject/screens/chatting_screen.dart';
import 'package:flutterproject/widgets/login_alarm_widget.dart';

class Comments extends StatefulWidget {
  final String board;
  final String docId;
  final String title;
  final String content;
  final String time;
  final String userName;
  const Comments({
    super.key,
    required this.board,
    required this.docId,
    required this.title,
    required this.content,
    required this.time,
    required this.userName,
  });

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  @override
  Widget build(BuildContext context) {
    bool isRecomment = false;
    int selectedIndex = -1;
    final user = FirebaseAuth.instance.currentUser;
    void showPopupMenu(BuildContext context, String yourId, String yourName) {
      showMenu(
        color: Palette.color7,
        context: context,
        position: const RelativeRect.fromLTRB(100, 400, 0, 0),
        items: [
          const PopupMenuItem(
            value: 1,
            child: Center(
              child: Text(
                '채팅하기',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const PopupMenuItem(
            value: 2,
            child: Center(
              child: Text(
                '댓글달기',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
        elevation: 8.0,
      ).then((value) {
        if (user != null) {
          if (value == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Chatting(
                        yourId: yourId,
                        yourName: yourName,
                      )),
            );
          } else if (value == 2) {}
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginAlarm()),
          );
        }
      });
    }

    void reComment(String docId, BuildContext context, int index) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: const Center(
                child: Text(
                  '대댓글을 작성하시겠습니까?',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('취소'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedIndex = index;
                          isRecomment = true;
                        });
                        NewComment(
                          board: widget.board,
                          docId: widget.docId,
                          commentDocId: docId,
                          isRecomment: isRecomment,
                        );
                        Navigator.pop(context);
                      },
                      child: const Text('확인'),
                    ),
                  ],
                ),
              ],
            );
          });
    }

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(widget.board)
            .doc(widget.docId)
            .collection('comment')
            .orderBy('time')
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final commentDocs = snapshot.data!.docs;
          return ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: commentDocs.length,
            itemBuilder: (context, index) {
              var docId = commentDocs[index].id;
              int recomment = commentDocs[index]['recomment'];
              return GestureDetector(
                onTap: () {
                  reComment(docId, context, index);
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  color: selectedIndex == index
                      ? Colors.black.withOpacity(0.3)
                      : Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                commentDocs[index]['userName'],
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                commentDocs[index]['comment'],
                              ),
                              Text(
                                commentDocs[index]['time']
                                    .toDate()
                                    .toString()
                                    .substring(5, 16),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                          commentDocs[index]['userId'] != user?.uid
                              ? IconButton(
                                  onPressed: () {
                                    showPopupMenu(
                                        context,
                                        commentDocs[index]['userId'],
                                        commentDocs[index]['userName']);
                                  },
                                  icon: const Icon(Icons.more_vert_rounded))
                              : Container(),
                        ],
                      ),
                      recomment > 0
                          ? TextButton(
                              onPressed: () {}, child: Text('답글 $recomment개'))
                          : const SizedBox(
                              height: 3,
                            ),
                      const Divider(
                        height: 1,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
