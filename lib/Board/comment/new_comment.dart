import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/Board/palette.dart';
import 'package:flutterproject/widgets/login_alarm_widget.dart';

class NewComment extends StatefulWidget {
  final String docId;
  final String board;
  final String commentDocId;
  final bool isRecomment;
  const NewComment({
    super.key,
    required this.board,
    required this.docId,
    required this.isRecomment,
    required this.commentDocId,
  });

  @override
  State<NewComment> createState() => _NewCommentState();
}

class _NewCommentState extends State<NewComment> {
  final _controller = TextEditingController();
  var _comment = '';
  void _saveComment() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginAlarm()));
    } else if (widget.isRecomment == false) {
      final snapshot = await FirebaseFirestore.instance
          .collection(widget.board)
          .doc(widget.docId)
          .get();
      await FirebaseFirestore.instance
          .collection(widget.board)
          .doc(widget.docId)
          .collection('comment')
          .add({
        'comment': _comment,
        'time': Timestamp.now(),
        'userName': user.displayName,
        'userId': user.uid,
        'recomment': 0,
      });
      int commentsCount = await snapshot.get('comments');
      await FirebaseFirestore.instance
          .collection(widget.board)
          .doc(widget.docId)
          .update({'comments': ++commentsCount});
      if (widget.board == 'hotBoard') {
        await FirebaseFirestore.instance
            .collection('freeBoard')
            .doc(widget.docId)
            .collection('comment')
            .add({
          'comment': _comment,
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
          'comment': _comment,
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
      _controller.clear();
      _comment = '';
    } else {
      _saveComment();
    }
  }

  void _saveRecomment() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final snapshot = await FirebaseFirestore.instance
        .collection(widget.board)
        .doc(widget.docId)
        .get();
    int commentsCount = await snapshot.get('comments');

    await FirebaseFirestore.instance
        .collection(widget.board)
        .doc(widget.docId)
        .update({'comments': ++commentsCount});

    int reCommentCount = await snapshot.get('recomment');

    await FirebaseFirestore.instance
        .collection(widget.board)
        .doc(widget.docId)
        .collection('comment')
        .doc(widget.commentDocId)
        .update({'recomment': ++reCommentCount});

    await FirebaseFirestore.instance
        .collection(widget.board)
        .doc(widget.docId)
        .collection('comment')
        .doc(widget.commentDocId)
        .collection('recomment')
        .add({
      'comment': _comment,
      'time': Timestamp.now(),
      'userName': user!.displayName,
      'userId': user.uid,
    });
    _controller.clear();
    _comment = '';
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
                hintText: widget.isRecomment ? "대댓글을 입력하세요." : "댓글을 입력하세요.",
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
