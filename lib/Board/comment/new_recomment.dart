import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/Board/palette.dart';
import 'package:flutterproject/main.dart';
import 'package:flutterproject/widgets/login_alarm_widget.dart';
import 'package:provider/provider.dart';

class NewRecomment extends StatefulWidget {
  final String docId;
  final String board;
  const NewRecomment({
    super.key,
    required this.board,
    required this.docId,
  });

  @override
  State<NewRecomment> createState() => _NewRecommentState();
}

class _NewRecommentState extends State<NewRecomment> {
  final _controller = TextEditingController();
  var _comment = '';

  void _saveRecomment() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final commentDocId =
        Provider.of<ForRecomment>(context, listen: false).commentDocId;
    if (user == null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginAlarm()));
    } else {
      final snapshot = await FirebaseFirestore.instance
          .collection(widget.board)
          .doc(widget.docId)
          .get();
      int commentsCount = await snapshot.get('comments');

      await FirebaseFirestore.instance
          .collection(widget.board)
          .doc(widget.docId)
          .update({'comments': ++commentsCount});

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
          .update({'recomment': ++reCommentCount});

      await FirebaseFirestore.instance
          .collection(widget.board)
          .doc(widget.docId)
          .collection('comment')
          .doc(commentDocId)
          .collection('recomment')
          .add({
        'comment': _comment,
        'time': Timestamp.now(),
        'userName': user.displayName,
        'userId': user.uid,
      });
      _controller.clear();
      _comment = '';
      if (!context.mounted) return;
      Provider.of<ForRecomment>(context, listen: false).update('', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        color: Palette.color6,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              maxLines: null,
              controller: _controller,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: "대댓글을 입력하세요.",
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                filled: true,
                fillColor: Palette.color6,
                border: InputBorder.none,
              ),
              onChanged: (value) {
                setState(() {
                  _comment = value;
                });
              },
            ),
          ),
          IconButton(
            onPressed: _comment.trim().isEmpty ? null : _saveRecomment,
            icon: const Icon(Icons.send),
            color: _comment.trim().isEmpty ? Colors.white : Colors.black,
          ),
        ],
      ),
    );
  }
}
