import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/chatting/chat/recent_message.dart';

class Chat extends StatefulWidget {
  const Chat({
    super.key,
  });

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  '메세지',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('recentChat')
                    .doc(user!.uid)
                    .collection('recentChat')
                    .orderBy('time', descending: true)
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
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
                      return RecentMessage(
                        yourId: chatDocs[index]['yourId'],
                        yourName: chatDocs[index]['yourName'],
                        recentChat: chatDocs[index]['message'],
                        time: chatDocs[index]['time'].toDate(),
                      );
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}
