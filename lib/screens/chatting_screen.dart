import 'package:flutter/material.dart';
import 'package:flutterproject/chatting/chat/message.dart';
import 'package:flutterproject/chatting/chat/new_message.dart';

class Chatting extends StatefulWidget {
  final String yourId;
  const Chatting({
    super.key,
    required this.yourId,
  });

  @override
  State<Chatting> createState() => _ChattingState();
}

class _ChattingState extends State<Chatting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Expanded(
          child: Messages(
        yourId: widget.yourId,
      )),
      NewMessage(yourId: widget.yourId)
    ]));
  }
}
