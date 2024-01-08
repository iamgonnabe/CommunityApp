import 'package:flutter/material.dart';
import 'package:flutterproject/screens/chatting_screen.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: const Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text('메시지'),
          ],
        ),
      ),
    );
  }
}
