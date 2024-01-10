import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessage extends StatefulWidget {
  final String yourId;
  final String yourName;
  const NewMessage({
    super.key,
    required this.yourId,
    required this.yourName,
  });

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  var _userEnterMessage = '';
  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('chat')
        .doc(user!.uid)
        .collection(widget.yourId)
        .add({
      'message': _userEnterMessage,
      'time': Timestamp.now(),
      'userId': user.uid,
    });
    await FirebaseFirestore.instance
        .collection('chat')
        .doc(widget.yourId)
        .collection(user.uid)
        .add({
      'message': _userEnterMessage,
      'time': Timestamp.now(),
      'userId': user.uid,
    });
    await FirebaseFirestore.instance
        .collection('recentChat')
        .doc(user.uid)
        .collection('recentChat')
        .doc(widget.yourId)
        .set({
      'yourId': widget.yourId,
      'yourName': widget.yourName,
      'message': _userEnterMessage,
      'time': Timestamp.now(),
    });
    await FirebaseFirestore.instance
        .collection('recentChat')
        .doc(widget.yourId)
        .collection('recentChat')
        .doc(user.uid)
        .set({
      'yourId': user.uid,
      'yourName': widget.yourName,
      'message': _userEnterMessage,
      'time': Timestamp.now(),
    });
    _controller.clear();
    _userEnterMessage = '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.black12,
      ),
      height: 60,
      margin: const EdgeInsets.only(top: 8, bottom: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              maxLines: null,
              controller: _controller,
              decoration: InputDecoration(
                hintText: "메시지 보내기...",
                hintStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.black.withOpacity(0.7),
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                setState(() {
                  _userEnterMessage = value;
                });
              },
            ),
          ),
          IconButton(
            onPressed: _userEnterMessage.trim().isEmpty ? null : _sendMessage,
            icon: const Icon(Icons.send),
            color: _userEnterMessage.trim().isEmpty
                ? Colors.white
                : Colors.blueAccent,
          ),
        ],
      ),
    );
  }
}
