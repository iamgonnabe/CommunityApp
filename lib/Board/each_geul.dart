import 'package:flutter/material.dart';
import 'package:flutterproject/Board/palette.dart';

class GotoEachGeul extends StatefulWidget {
  final String title;
  final String content;
  final String time;
  final String userName;
  const GotoEachGeul(
      {super.key,
      required this.title,
      required this.content,
      required this.time,
      required this.userName});

  @override
  State<GotoEachGeul> createState() => _GotoEachGeulState();
}

class _GotoEachGeulState extends State<GotoEachGeul> {
  var _comment = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '자유 게시판',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Palette.color1,
        leading: const Icon(
          Icons.chevron_left,
          color: Colors.white,
          size: 40,
        ),
        actions: const [
          Icon(
            Icons.edit,
            color: Colors.white,
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
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
            SingleChildScrollView(
              child: SizedBox(
                height: 300,
                child: Column(
                  children: [
                    Text(widget.content),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      height: 1,
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: TextField(
                style: const TextStyle(color: Colors.black),
                maxLines: null,
                decoration: const InputDecoration(hintText: "제목"),
                onChanged: (value) {
                  setState(() {
                    _comment = value;
                  });
                },
              ),
            ),
            const SingleChildScrollView(),
          ],
        ),
      ),
    );
  }
}
