import 'package:flutter/material.dart';
import 'package:flutterproject/Board/palette.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  const ChatBubble(this.message, this.isMe, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        isMe
            ? Container()
            : const Icon(
                Icons.account_circle_rounded,
                color: Colors.black26,
                size: 50,
              ),
        Container(
          decoration: BoxDecoration(
            color: isMe ? Palette.color6 : Colors.black45,
            borderRadius: BorderRadius.only(
              topRight: const Radius.circular(12),
              topLeft: const Radius.circular(12),
              bottomRight:
                  isMe ? const Radius.circular(0) : const Radius.circular(12),
              bottomLeft:
                  isMe ? const Radius.circular(12) : const Radius.circular(0),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          constraints: const BoxConstraints(
            maxWidth: 250,
          ),
          child: Text(
            message,
            softWrap: true,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
