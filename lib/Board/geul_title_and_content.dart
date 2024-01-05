import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TitleAndContent extends StatefulWidget {
  final String board;
  final String docId;
  final String title;
  final String content;
  final String time;
  final String userName;
  final String userId;
  const TitleAndContent({
    super.key,
    required this.board,
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
  late SharedPreferences prefs;
  bool isLiked = false;
  int likes = 0;
  @override
  void initState() {
    super.initState();
    _loadLikeStatus();
  }

  Future _loadLikeStatus() async {
    final snapshot = await FirebaseFirestore.instance
        .collection(widget.board)
        .doc(widget.docId)
        .get();
    setState(() {
      likes = snapshot.get('likes');
    });
    prefs = await SharedPreferences.getInstance();
    final likedGeul = prefs.getStringList('likedGeul');
    if (likedGeul != null) {
      if (likedGeul.contains(widget.userId) &&
          likedGeul.contains(widget.docId)) {
        setState(() {
          isLiked = true;
        });
      }
    } else {
      await prefs.setStringList('likedGeul', []);
    }
  }

  void _onHeartTap() async {
    final likedGeul = prefs.getStringList('likedGeul');
    if (likedGeul != null) {
      if (isLiked) {
        likedGeul.remove(widget.userId);
        likedGeul.remove(widget.docId);
        setState(() {
          likes--;
        });
      } else {
        likedGeul.add(widget.userId);
        likedGeul.add(widget.docId);
        setState(() {
          likes++;
        });
      }
      await prefs.setStringList('likedGeul', likedGeul);
      await FirebaseFirestore.instance
          .collection(widget.board)
          .doc(widget.docId)
          .update({'likes': likes});
      setState(() {
        isLiked = !isLiked;
      });
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
                  onPressed: _onHeartTap,
                  icon: isLiked
                      ? const Icon(Icons.favorite_rounded)
                      : const Icon(Icons.favorite_outline_rounded),
                  color: isLiked ? Colors.red : Colors.black,
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
