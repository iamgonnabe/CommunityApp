import 'package:flutter/material.dart';
import 'package:flutterproject/Board/palette.dart';
import 'package:flutterproject/models/product_model.dart';
import 'package:get/get.dart';

class ReviewGeul extends StatefulWidget {
  final ProductModel product;
  const ReviewGeul({super.key, required this.product});

  @override
  State<ReviewGeul> createState() => _ReviewGeulState();
}

class _ReviewGeulState extends State<ReviewGeul> {
  final _controller = TextEditingController();
  var _comment = '';
  bool isLiked = false;
  bool isDisliked = false;
  int likes = 0;
  int dislikes = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('리뷰 게시판'),
        foregroundColor: Colors.white,
        backgroundColor: Palette.color1,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Container(
                  width: 200,
                  height: 200,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Image.network(
                    widget.product.image,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 200,
                child: Center(
                  child: Text(
                    widget.product.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isLiked = !isLiked;
                            if (isLiked) {
                              likes++;
                            } else {
                              likes--;
                            }
                          });
                        },
                        icon: isLiked
                            ? const Icon(
                                Icons.thumb_up_alt_rounded,
                                color: Colors.blue,
                              )
                            : const Icon(Icons.thumb_up_alt_outlined),
                      ),
                      const Text('추천'),
                      Text(likes.toString()),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isDisliked = !isDisliked;
                            if (isDisliked) {
                              dislikes++;
                            } else {
                              dislikes--;
                            }
                          });
                        },
                        icon: isDisliked
                            ? const Icon(Icons.thumb_down_alt_rounded)
                            : const Icon(Icons.thumb_down_alt_outlined),
                      ),
                      const Text('비추'),
                      Text(dislikes.toString()),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                height: 2,
                color: Colors.black,
              ),
              Container(
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  color: Palette.color6,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        maxLines: null,
                        controller: _controller,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "댓글을 입력하세요.",
                          hintStyle:
                              TextStyle(color: Colors.white.withOpacity(0.6)),
                          filled: true,
                          fillColor: Palette.color6,
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          setState(() {
                            _comment = value;
                          });
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.send),
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
