import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterproject/chatting/chat/chat_bubble.dart';

class Messages extends StatelessWidget {
  final String yourId;
  const Messages({
    super.key,
    required this.yourId,
  });

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .doc(user!.uid)
            .collection(yourId)
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
              reverse: true,
              itemCount: chatDocs.length,
              itemBuilder: (context, index) {
                return ChatBubble(chatDocs[index]['message'],
                    chatDocs[index]['userId'].toString() == user.uid);
              });
        });
  }
}
