import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/Board/palette.dart';
import 'package:flutterproject/widgets/login_alarm_widget.dart';

class NewComment extends StatefulWidget {
  final String docId;
  final String board;
  const NewComment({
    super.key,
    required this.board,
    required this.docId,
  });

  @override
  State<NewComment> createState() => _NewCommentState();
}

class _NewCommentState extends State<NewComment> {
  final _controller = TextEditingController();
  var _comment = '';
  void _saveComment() async {
    FocusScope.of(context).unfocus();
    String comment = _comment;
    _controller.clear();
    _comment = '';
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginAlarm()));
    } else {
      await FirebaseFirestore.instance
          .collection(widget.board)
          .doc(widget.docId)
          .collection('comment')
          .add({
        'comment': comment,
        'time': Timestamp.now(),
        'userName': user.displayName,
        'userId': user.uid,
        'recomment': 0,
      });
      final snapshot = await FirebaseFirestore.instance
          .collection(widget.board)
          .doc(widget.docId)
          .get();
      int commentsCount = await snapshot.get('comments');
      await FirebaseFirestore.instance
          .collection(widget.board)
          .doc(widget.docId)
          .update({'comments': ++commentsCount});
<<<<<<< HEAD
=======
      if (widget.board == 'hotBoard') {
        await FirebaseFirestore.instance
            .collection('freeBoard')
            .doc(widget.docId)
            .collection('comment')
            .add({
          'comment': comment,
          'time': Timestamp.now(),
          'userName': user.displayName,
          'userId': user.uid,
          'recomment': 0,
        });
        await FirebaseFirestore.instance
            .collection('freeBoard')
            .doc(widget.docId)
            .update({'comments': commentsCount});
      } else if (widget.board == 'freeBoard' && snapshot.get('likes') > 0) {
        await FirebaseFirestore.instance
            .collection('hotBoard')
            .doc(widget.docId)
            .collection('comment')
            .add({
          'comment': comment,
          'time': Timestamp.now(),
          'userName': user.displayName,
          'userId': user.uid,
          'recomment': 0,
        });
        await FirebaseFirestore.instance
            .collection('hotBoard')
            .doc(widget.docId)
            .update({'comments': commentsCount});
      }
>>>>>>> origin/main
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
                hintText: "댓글을 입력하세요.",
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
            onPressed: _comment.trim().isEmpty ? null : _saveComment,
            icon: const Icon(Icons.send),
            color: _comment.trim().isEmpty ? Colors.white : Colors.black,
          ),
        ],
      ),
    );
  }
}
