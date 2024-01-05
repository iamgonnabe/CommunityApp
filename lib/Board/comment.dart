import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
            shrinkWrap: true,
            primary: false,
            itemCount: chatDocs.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      chatDocs[index]['userName'],
                    ),
                    const SizedBox(
                      height: 3,
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
