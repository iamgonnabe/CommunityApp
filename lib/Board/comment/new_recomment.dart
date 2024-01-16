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
      String comment = _comment;
      _controller.clear();
      _comment = '';
      await FirebaseFirestore.instance
          .collection(widget.board)
          .doc(widget.docId)
          .collection('comment')
          .doc(commentDocId)
          .collection('recomment')
          .add({
        'comment': comment,
        'time': Timestamp.now(),
        'userName': user.displayName,
        'userId': user.uid,
      }); //대댓글 저장
      final snapshot = await FirebaseFirestore.instance
          .collection(widget.board)
          .doc(widget.docId)
          .get();
      int commentsCount = await snapshot.get('comments');

      await FirebaseFirestore.instance
          .collection(widget.board)
          .doc(widget.docId)
          .update({'comments': ++commentsCount}); //댓글 수 업뎃

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
          .update({'recomment': ++reCommentCount}); //대댓글 수 없뎃
      if (!context.mounted) return;
      Provider.of<ForRecomment>(context, listen: false).update('', false);
      Provider.of<ForRecomment>(context, listen: false).selected(-1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 3,
            ),
            onPressed: () {
              Provider.of<ForRecomment>(context, listen: false)
                  .update(widget.docId, false);
              Provider.of<ForRecomment>(context, listen: false).selected(-1);
            },
            child: const Text(
              '취소',
            )),
        Container(
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
        ),
      ],
    );
  }
}
