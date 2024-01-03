import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/Board/geul_byBoards.dart';

class Geul extends StatelessWidget {
  final String board;
  const Geul({super.key, required this.board});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
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
          final chatDocs = snapshot.data!.docs;
          return ListView.builder(
              itemCount: chatDocs.length,
              itemBuilder: (context, index) {
                return GeulByBoards(
                  title: chatDocs[index]['title'],
                  content: chatDocs[index]['content'],
                  userName: chatDocs[index]['userName'],
                  time: chatDocs[index]['time']
                      .toDate()
                      .toString()
                      .substring(0, 19),
                );
              });
        });
  }
}
