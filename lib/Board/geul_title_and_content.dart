import 'package:flutter/material.dart';

class titleAndContent extends StatefulWidget {
  final String title;
  final String content;
  final String time;
  final String userName;
  const titleAndContent({
    super.key,
    required this.title,
    required this.content,
    required this.time,
    required this.userName,
  });

  @override
  State<titleAndContent> createState() => _titleAndContentState();
}

class _titleAndContentState extends State<titleAndContent> {
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
        Center(
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              color: Colors.white,
            ),
            child: const Icon(
              Icons.favorite_outline_rounded,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          height: 1,
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
