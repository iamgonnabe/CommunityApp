import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/Board/geul_title_and_content.dart';

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
          final chatDocs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: chatDocs.length,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                  padding: const EdgeInsets.all(6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleAndContent(
                          title: title,
                          content: content,
                          time: time,
                          userName: userName),
                      Text(chatDocs[index]['userId']),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(chatDocs[index]['comment']),
                      Text(
                        chatDocs[index]['time']
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
                );
              }
              return Container(
                padding: const EdgeInsets.all(6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(
                      height: 1,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      chatDocs[index]['userId'],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      chatDocs[index]['comment'],
                    ),
                    Text(
                      chatDocs[index]['time']
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
              );
            },
          );
        });
  }
}
