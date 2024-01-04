import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewGeul extends StatefulWidget {
  final String board;
  const NewGeul({super.key, required this.board});

  @override
  State<NewGeul> createState() => _NewGeulState();
}

class _NewGeulState extends State<NewGeul> {
  final ScrollController _scrollController = ScrollController();
  var _title = '';
  var _content = '';
  void _writeGeul() {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection(widget.board).add({
      'title': _title,
      'content': _content,
      'userName': user!.displayName,
      'time': Timestamp.now(),
    });
    Navigator.pop(context);
  }

  void _noContent() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: const Text('내용을 입력하세요'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("확인"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('글 쓰기'),
        leading: IconButton(
          icon: const Icon(Icons.cancel_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          ElevatedButton(
              onPressed: _title.trim().isEmpty || _content.trim().isEmpty
                  ? _noContent
                  : _writeGeul,
              child: const Text('완료')),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: SingleChildScrollView(
                child: TextField(
                  style: const TextStyle(color: Colors.black),
                  maxLines: null,
                  decoration: const InputDecoration(hintText: "제목"),
                  onChanged: (value) {
                    setState(() {
                      _title = value;
                    });
                  },
                ),
              ),
            ),
            SingleChildScrollView(
              controller: _scrollController,
              child: SizedBox(
                height: 230,
                child: TextField(
                  maxLines: null,
                  expands: true,
                  decoration: const InputDecoration(hintText: "내용을 입력하세요."),
                  onChanged: (value) {
                    setState(() {
                      _content = value;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
