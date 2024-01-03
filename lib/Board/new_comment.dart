import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewComment extends StatefulWidget {
  final String title;
  final String board;
  const NewComment({super.key, required this.title, required this.board});

  @override
  State<NewComment> createState() => _NewCommentState();
}

class _NewCommentState extends State<NewComment> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
