import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewOrEditGeul extends StatefulWidget {
  final String board;
  final String title;
  final String content;
  final String docId;
  final bool isEdit;
  const NewOrEditGeul({
    super.key,
    required this.board,
    required this.content,
    required this.title,
    required this.docId,
    required this.isEdit,
  });

  @override
  State<NewOrEditGeul> createState() => _NewOrEditGeulState();
}

class _NewOrEditGeulState extends State<NewOrEditGeul> {
  final ScrollController _scrollController = ScrollController();
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late String _title;
  late String _content;
  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _contentController = TextEditingController(text: widget.content);
    _title = widget.isEdit ? widget.title : '';
    _content = widget.isEdit ? widget.content : '';
  }

  void _writeGeul() {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection(widget.board).add({
      'title': _title,
      'content': _content,
      'userName': user!.displayName,
      'time': Timestamp.now(),
      'userId': user.uid,
      'likes': 0,
      'comments': 0,
    });
    Navigator.pop(context);
  }

  void _editGeul() {
    final time = Timestamp.now();
    FocusScope.of(context).unfocus();
    FirebaseFirestore.instance
        .collection(widget.board)
        .doc(widget.docId)
        .update({
      'title': _title,
      'content': _content,
      'time': time,
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
                  : (widget.isEdit ? _editGeul : _writeGeul),
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
                  controller: widget.isEdit ? _titleController : null,
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
                  controller: widget.isEdit ? _contentController : null,
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
