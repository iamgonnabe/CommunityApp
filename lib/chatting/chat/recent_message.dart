import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/Board/palette.dart';
import 'package:flutterproject/screens/chatting_screen.dart';

class RecentMessage extends StatefulWidget {
  final String yourId;
  final String yourName;
  final String recentChat;
  final DateTime time;
  const RecentMessage({
    super.key,
    required this.yourId,
    required this.yourName,
    required this.recentChat,
    required this.time,
  });

  @override
  State<RecentMessage> createState() => _RecentMessageState();
}

class _RecentMessageState extends State<RecentMessage> {
  @override
  void initState() {
    super.initState();
    time();
  }

  String time() {
    DateTime current = Timestamp.now().toDate();
    Duration difference = current.difference(widget.time);
    int timepassed = difference.inMinutes;
    String count = '분 전';
    if (timepassed > 59) {
      timepassed = difference.inHours;
      count = '시간 전';
      if (timepassed > 23) {
        timepassed = difference.inDays;
        count = '일 전';
      }
    }
    return '$timepassed$count';
  }

  @override
  Widget build(BuildContext context) {
    String ago = time();
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Chatting(yourId: widget.yourId, yourName: widget.yourName)),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            const Icon(
              Icons.account_circle_rounded,
              size: 50,
              color: Palette.color8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.yourName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 250,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.recentChat,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                      ),
                      Text(ago),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
