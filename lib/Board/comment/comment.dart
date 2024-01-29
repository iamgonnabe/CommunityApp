import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/Board/palette.dart';
import 'package:flutterproject/main.dart';
import 'package:flutterproject/screens/chatting_screen.dart';
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
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context).user;
    void showPopupMenu(BuildContext context, String yourId, String yourName,
        String commentDocId, String recommentDocId, bool isRecomment) {
      showMenu(
        color: Palette.color7,
        context: context,
        position: const RelativeRect.fromLTRB(100, 500, 0, 0),
        items: [
          user!.uid == yourId
              ? const PopupMenuItem(
                  value: 1,
                  child: Center(
                    child: Text(
                      '삭제하기',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              : const PopupMenuItem(
                  value: 2,
                  child: Center(
                    child: Text(
                      '채팅하기',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
        ],
        elevation: 8.0,
      ).then((value) async {
        if (value == 1) {
          final snapshot = await FirebaseFirestore.instance
              .collection(widget.board)
              .doc(widget.docId)
              .get();
          int commentsCount = await snapshot.get('comments');
          await FirebaseFirestore.instance
              .collection(widget.board)
              .doc(widget.docId)
              .update({'comments': --commentsCount});
          if (isRecomment) {
            final snaps = await FirebaseFirestore.instance
                .collection(widget.board)
                .doc(widget.docId)
                .collection('comment')
                .doc(commentDocId)
                .get();
            int reCommentCount = await snaps.get('recomment');
            await FirebaseFirestore.instance
                .collection(widget.board)
                .doc(widget.docId)
                .collection('comment')
                .doc(commentDocId)
                .update({'recomment': --reCommentCount});
            await FirebaseFirestore.instance
                .collection('freeBoard')
                .doc(widget.docId)
                .collection('comment')
                .doc(commentDocId)
                .collection('recomment')
                .doc(recommentDocId)
                .delete();
          } else {
            await FirebaseFirestore.instance
                .collection(widget.board)
                .doc(widget.docId)
                .collection('comment')
                .doc(commentDocId)
                .delete();
          }
        } else if (value == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Chatting(
                      yourId: yourId,
                      yourName: yourName,
                    )),
          );
        }
      });
    }

    void reComment(String docId, BuildContext context, int index) {
      Provider.of<ForRecomment>(context, listen: false).selected(index);
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
                        Provider.of<ForRecomment>(context, listen: false)
                            .selected(-1);
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
              var commentdocId = commentDocs[index].id;
              return GestureDetector(
                onTap: () {
                  reComment(commentdocId, context, index);
                },
                child: Container(
                  padding: const EdgeInsets.only(right: 6, left: 6),
                  child: Container(
                    padding: const EdgeInsets.only(top: 6, left: 6),
                    color: Provider.of<ForRecomment>(context).selectedIndex ==
                            index
                        ? Colors.black.withOpacity(0.6)
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
                                  style: TextStyle(
                                    color: Provider.of<ForRecomment>(context)
                                                .selectedIndex ==
                                            index
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  commentDocs[index]['comment'],
                                  style: TextStyle(
                                    color: Provider.of<ForRecomment>(context)
                                                .selectedIndex ==
                                            index
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                Text(
                                  commentDocs[index]['time']
                                      .toDate()
                                      .toString()
                                      .substring(5, 16),
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Provider.of<ForRecomment>(context)
                                                  .selectedIndex ==
                                              index
                                          ? Colors.white.withOpacity(0.8)
                                          : Colors.grey.withOpacity(0.8)),
                                ),
                              ],
                            ),
                            user != null
                                ? IconButton(
                                    onPressed: () {
                                      showPopupMenu(
                                          context,
                                          commentDocs[index]['userId'],
                                          commentDocs[index]['userName'],
                                          commentdocId,
                                          '',
                                          false);
                                    },
                                    icon: const Icon(Icons.more_vert_rounded),
                                    color: Provider.of<ForRecomment>(context)
                                                .selectedIndex ==
                                            index
                                        ? Colors.white
                                        : Colors.black,
                                  )
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
                                .doc(commentdocId)
                                .collection('recomment')
                                .orderBy('time')
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<
                                        QuerySnapshot<Map<String, dynamic>>>
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
                                  var recommentDocId = recommentDocs[indexa].id;
                                  return GestureDetector(
                                    onTap: () {
                                      reComment(commentdocId, context, index);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          top: 6, left: 6),
                                      color: Colors.black.withOpacity(0.1),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .subdirectory_arrow_right_rounded,
                                                    size: 15,
                                                    color: Provider.of<ForRecomment>(
                                                                    context)
                                                                .selectedIndex ==
                                                            index
                                                        ? Colors.white
                                                        : Colors.black,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(
                                                        height: 3,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            recommentDocs[
                                                                    indexa]
                                                                ['userName'],
                                                            style: TextStyle(
                                                              color: Provider.of<ForRecomment>(
                                                                              context)
                                                                          .selectedIndex ==
                                                                      index
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 3,
                                                          ),
                                                          Text(
                                                            recommentDocs[
                                                                    indexa]
                                                                ['comment'],
                                                            style: TextStyle(
                                                              color: Provider.of<ForRecomment>(
                                                                              context)
                                                                          .selectedIndex ==
                                                                      index
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                            ),
                                                          ),
                                                          Text(
                                                            recommentDocs[
                                                                        indexa]
                                                                    ['time']
                                                                .toDate()
                                                                .toString()
                                                                .substring(
                                                                    5, 16),
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Provider.of<ForRecomment>(context)
                                                                            .selectedIndex ==
                                                                        index
                                                                    ? Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.8)
                                                                    : Colors
                                                                        .grey
                                                                        .withOpacity(
                                                                            0.8)),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              user != null
                                                  ? IconButton(
                                                      onPressed: () {
                                                        showPopupMenu(
                                                            context,
                                                            recommentDocs[
                                                                    indexa]
                                                                ['userId'],
                                                            recommentDocs[
                                                                    indexa]
                                                                ['userName'],
                                                            commentdocId,
                                                            recommentDocId,
                                                            true);
                                                      },
                                                      icon: const Icon(Icons
                                                          .more_vert_rounded),
                                                      color: Provider.of<ForRecomment>(
                                                                      context)
                                                                  .selectedIndex ==
                                                              index
                                                          ? Colors.white
                                                          : Colors.black,
                                                    )
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
                                    ),
                                  );
                                },
                              );
                            }),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }
}
