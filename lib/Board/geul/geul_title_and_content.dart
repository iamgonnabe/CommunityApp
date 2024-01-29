import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/controller/controller.dart';
import 'package:flutterproject/widgets/login_alarm_widget.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TitleAndContent extends StatefulWidget {
  final String docId;
  final String title;
  final String content;
  final String time;
  final String userName;
  final String userId;
  const TitleAndContent({
    super.key,
    required this.docId,
    required this.title,
    required this.content,
    required this.time,
    required this.userName,
    required this.userId,
  });

  @override
  State<TitleAndContent> createState() => _TitleAndContentState();
}

class _TitleAndContentState extends State<TitleAndContent> {
  final controller = Get.put(Controller());
  late SharedPreferences prefs;
  int likes = 0;
  int comments = 0;
  final user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    _loadLikeStatus();
  }

  Future _loadLikeStatus() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('freeBoard')
        .doc(widget.docId)
        .get();
    setState(() {
      likes = snapshot.get('likes');
    });
    prefs = await SharedPreferences.getInstance();
    final likedGeul = prefs.getStringList('likedGeul');
    if (likedGeul != null) {
      if (likedGeul.contains(user?.uid) && likedGeul.contains(widget.docId)) {
<<<<<<< HEAD
        controller.isLike.value = true;
=======
        setState(() {
          controller.isLike.value = true;
        });
      } else {
        controller.isLike.value = false;
>>>>>>> origin/main
      }
    } else {
      await prefs.setStringList('likedGeul', []);
    }
  }

  void _login() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginAlarm()));
  }

  void _onHeartTap() async {
    final likedGeul = prefs.getStringList('likedGeul');
    if (likedGeul != null) {
      if (controller.isLike.value == true) {
        likedGeul.remove(user!.uid);
        likedGeul.remove(widget.docId);
        setState(() {
          likes--;
        });
      } else {
        likedGeul.add(user!.uid);
        likedGeul.add(widget.docId);
        setState(() {
          likes++;
        });
      }
      setState(() {
        controller.isLike.toggle();
      });
      await prefs.setStringList('likedGeul', likedGeul);
      await FirebaseFirestore.instance
          .collection('freeBoard')
          .doc(widget.docId)
          .update({'likes': likes});
<<<<<<< HEAD
=======
      if (likes == 0) {
        await FirebaseFirestore.instance
            .collection('hotBoard')
            .doc(widget.docId)
            .delete();
        await FirebaseFirestore.instance
            .collection('freeBoard')
            .doc(widget.docId)
            .update({'likes': likes});
      } else if (likes > 0 && widget.board == 'freeBoard') {
        final data = await FirebaseFirestore.instance
            .collection(widget.board)
            .doc(widget.docId)
            .get();
        comments = data.get('comments');

        await FirebaseFirestore.instance
            .collection('hotBoard')
            .doc(widget.docId)
            .set({
          'title': widget.title,
          'content': widget.content,
          'userName': widget.userName,
          'userId': widget.userId,
          'time': Timestamp.now(),
          'likes': likes,
          'comments': comments,
        });
        final snapshot = await FirebaseFirestore.instance
            .collection('freeBoard')
            .doc(widget.docId)
            .collection('comment')
            .get();
        for (var doc in snapshot.docs) {
          Map<String, dynamic> dataToCopy = doc.data();
          var commentId = doc.id;
          await FirebaseFirestore.instance
              .collection('hotBoard')
              .doc(widget.docId)
              .collection('comment')
              .doc(commentId)
              .set(dataToCopy);
          final snapshot1 = await FirebaseFirestore.instance
              .collection('freeBoard')
              .doc(widget.docId)
              .collection('comment')
              .doc(commentId)
              .collection('recomment')
              .get();
          if (snapshot1.docs.isNotEmpty) {
            for (var doc1 in snapshot1.docs) {
              Map<String, dynamic> dataToCopy1 = doc1.data();
              await FirebaseFirestore.instance
                  .collection('hotBoard')
                  .doc(widget.docId)
                  .collection('comment')
                  .doc(commentId)
                  .collection('recomment')
                  .add(dataToCopy1);
            }
          }
        }
        await FirebaseFirestore.instance
            .collection('hotBoard')
            .doc(widget.docId)
            .update({'likes': likes});
      } else if (widget.board == 'hotBoard') {
        await FirebaseFirestore.instance
            .collection('freeBoard')
            .doc(widget.docId)
            .update({'likes': likes});
      }
    } else {
      likes = 0;
>>>>>>> origin/main
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Text(
              widget.userName,
              style: TextStyle(color: Colors.black.withOpacity(0.7)),
            ),
            Text(
              ' | ',
              style: TextStyle(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
            Text(
              widget.time,
              style: TextStyle(color: Colors.black.withOpacity(0.7)),
            ),
          ],
        ),
        const Divider(
          height: 1,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(widget.content),
        const SizedBox(
          height: 200,
        ),
        Container(
          padding: const EdgeInsets.all(0),
          child: Center(
            child: Column(
              children: [
                IconButton(
                  onPressed: user == null ? _login : _onHeartTap,
                  icon: user == null
                      ? const Icon(Icons.favorite_outline)
                      : (controller.isLike.value
                          ? const Icon(Icons.favorite_rounded)
                          : const Icon(Icons.favorite_outline_rounded)),
                  color: user == null
                      ? Colors.black
                      : (controller.isLike.value ? Colors.red : Colors.black),
                ),
                Text(likes.toString()),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          height: 1,
        ),
      ],
    );
  }
}
