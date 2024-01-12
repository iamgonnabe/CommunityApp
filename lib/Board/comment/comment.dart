import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/Board/palette.dart';
import 'package:flutterproject/main.dart';
import 'package:flutterproject/screens/chatting_screen.dart';
import 'package:flutterproject/widgets/login_alarm_widget.dart';
import 'package:provider/provider.dart';

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
  final GlobalKey iconButtonKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    int selectedIndex = -1;
    final user = FirebaseAuth.instance.currentUser;
    void showPopupMenu(
        BuildContext context, String yourId, String yourName, Rect buttonRect) {
      final RenderBox overlay =
          Overlay.of(context).context.findRenderObject() as RenderBox;

      final RelativeRect position = RelativeRect.fromRect(
        buttonRect,
        const Offset(10, -40) & overlay.size,
      );

      showMenu(
        color: Palette.color7,
        context: context,
        position: position,
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
          }
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
                        Provider.of<ForRecomment>(context, listen: false)
                            .update(docId, false);
                        Navigator.pop(context);
                      },
                      child: const Text('취소'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Provider.of<ForRecomment>(context, listen: false)
                            .update(docId, true);
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
                                  key: iconButtonKey,
                                  onPressed: () {
                                    final RenderBox renderBox = iconButtonKey
                                        .currentContext!
                                        .findRenderObject() as RenderBox;
                                    final Rect buttonRect =
                                        renderBox.localToGlobal(Offset.zero) &
                                            renderBox.size;
                                    showPopupMenu(
                                        context,
                                        commentDocs[index]['userId'],
                                        commentDocs[index]['userName'],
                                        buttonRect);
                                  },
                                  icon: const Icon(Icons.more_vert_rounded))
                              : Container(),
                        ],
                      ),
                      const Divider(
                        height: 1,
                      ),
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection(widget.board)
                              .doc(widget.docId)
                              .collection('comment')
                              .doc(docId)
                              .collection('recomment')
                              .orderBy('time')
                              .snapshots(),
                          builder: (context,
                              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                  snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            final recommentDocs = snapshot.data!.docs;
                            return ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              itemCount: recommentDocs.length,
                              itemBuilder: (context, indexa) {
                                return GestureDetector(
                                  onTap: () {
                                    reComment(docId, context, index);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        top: 6, left: 6, right: 6),
                                    color: Colors.black.withOpacity(0.1),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons
                                                  .subdirectory_arrow_right_rounded,
                                              size: 15,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          recommentDocs[indexa]
                                                              ['userName'],
                                                        ),
                                                        const SizedBox(
                                                          height: 3,
                                                        ),
                                                        Text(
                                                          recommentDocs[indexa]
                                                              ['comment'],
                                                        ),
                                                        Text(
                                                          recommentDocs[indexa]
                                                                  ['time']
                                                              .toDate()
                                                              .toString()
                                                              .substring(5, 16),
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.8),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    recommentDocs[indexa]
                                                                ['userId'] !=
                                                            user?.uid
                                                        ? IconButton(
                                                            key: iconButtonKey,
                                                            onPressed: () {
                                                              final RenderBox
                                                                  renderBox =
                                                                  iconButtonKey
                                                                          .currentContext!
                                                                          .findRenderObject()
                                                                      as RenderBox;
                                                              final Rect
                                                                  buttonRect =
                                                                  renderBox.localToGlobal(
                                                                          Offset
                                                                              .zero) &
                                                                      renderBox
                                                                          .size;
                                                              showPopupMenu(
                                                                  context,
                                                                  recommentDocs[
                                                                          indexa]
                                                                      [
                                                                      'userId'],
                                                                  recommentDocs[
                                                                          indexa]
                                                                      [
                                                                      'userName'],
                                                                  buttonRect);
                                                            },
                                                            icon: const Icon(Icons
                                                                .more_vert_rounded))
                                                        : Container(),
                                                  ],
                                                ),
                                              ],
                                            ),
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
                                  ),
                                );
                              },
                            );
                          }),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
