import 'package:flutter/material.dart';
import 'package:flutterproject/Board/palette.dart';
import 'package:flutterproject/chatting/chat/message.dart';
import 'package:flutterproject/chatting/chat/new_message.dart';

class Chatting extends StatefulWidget {
  final String yourId;
  final String yourName;
  const Chatting({
    super.key,
    required this.yourId,
    required this.yourName,
  });

  @override
  State<Chatting> createState() => _ChattingState();
}

class _ChattingState extends State<Chatting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.yourName),
          backgroundColor: Palette.color8,
          foregroundColor: Colors.white,
        ),
        body: Column(children: [
          Expanded(
              child: Messages(
            yourId: widget.yourId,
          )),
          NewMessage(
            yourId: widget.yourId,
            yourName: widget.yourName,
          )
        ]));
  }
}
