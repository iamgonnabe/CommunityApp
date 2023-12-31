import 'package:flutter/material.dart';
import 'package:flutterproject/repository/chat_repository.dart';

class Chatting extends StatelessWidget {
  const Chatting({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 10,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemBuilder: (context, index) {
        ChatRepository chatRepository = ChatRepository();
        return Container(
          child: const Column(
            children: [
              //for (var chat in chatRepository.chats) Text(chat[index]['message'])
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
    );
  }
}
