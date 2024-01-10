import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/Board/palette.dart';
import 'package:flutterproject/screens/chatting_screen.dart';
import 'package:flutterproject/widgets/login_alarm_widget.dart';

class Comments extends StatelessWidget {
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
  Widget build(BuildContext context) {
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
        if (value != null) {
          if (user != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Chatting(
                        yourId: yourId,
                        yourName: yourName,
                      )),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginAlarm()),
            );
          }
        }
      });
    }

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(board)
            .doc(docId)
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
              return Container(
                padding: const EdgeInsets.all(6),
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
                    const SizedBox(
                      height: 3,
                    ),
                    const Divider(
                      height: 1,
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}
