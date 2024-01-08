import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/Board/geul/geul_preview.dart';

class Geul extends StatelessWidget {
  final String board;
  const Geul({super.key, required this.board});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(board)
            .orderBy('time', descending: true)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final geulDocs = snapshot.data!.docs;
          return ListView.separated(
            itemCount: geulDocs.length,
            itemBuilder: (context, index) {
              var docId = geulDocs[index].id;
              if (board == 'freeBoard') {
                return GeulPreview(
                  board: board,
                  title: geulDocs[index]['title'],
                  content: geulDocs[index]['content'],
                  userName: geulDocs[index]['userName'],
                  time: geulDocs[index]['time']
                      .toDate()
                      .toString()
                      .substring(0, 19),
                  docId: docId,
                  userId: geulDocs[index]['userId'],
                );
              } else if (board == 'hotBoard') {
                return GeulPreview(
                  board: board,
                  title: geulDocs[index]['title'],
                  content: geulDocs[index]['content'],
                  userName: geulDocs[index]['userName'],
                  time: geulDocs[index]['time']
                      .toDate()
                      .toString()
                      .substring(0, 19),
                  docId: docId,
                  userId: 'IdontCare',
                );
              }
              return null;
            },
            separatorBuilder: (context, index) => const Divider(
              height: 1,
            ),
          );
        });
  }
}
