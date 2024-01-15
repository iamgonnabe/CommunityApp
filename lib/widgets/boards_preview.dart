import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/Board/geul/each_geul_screen.dart';
import 'package:flutterproject/Board/palette.dart';

class BoardsPreview extends StatelessWidget {
  final String board;
  const BoardsPreview({
    super.key,
    required this.board,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: 300,
      height: 250,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [
            Palette.color7,
            Palette.color1,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 5,
            offset: const Offset(10, 10),
          ),
        ],
      ),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(board)
            .orderBy('time', descending: true)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final geulDocs = snapshot.data!.docs;
          return ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: geulDocs.length,
              itemBuilder: (context, index) {
                var docId = geulDocs[index].id;
                if (index < 4) {
                  if (board == 'freeBoard') {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EachGeul(
                                    board: board,
                                    title: geulDocs[index]['title'],
                                    content: geulDocs[index]['content'],
                                    userName: geulDocs[index]['userName'],
                                    time: geulDocs[index]['time']
                                        .toDate()
                                        .toString()
                                        .substring(0, 19),
                                    docId: docId,
                                    userId: geulDocs[index]['userId'])));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            geulDocs[index]['title'],
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black.withOpacity(0.7),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                geulDocs[index]['time']
                                            .toDate()
                                            .toString()
                                            .substring(0, 9) ==
                                        DateTime.now()
                                            .toString()
                                            .substring(0, 9)
                                    ? geulDocs[index]['time']
                                        .toDate()
                                        .toString()
                                        .substring(11, 16)
                                    : geulDocs[index]['time']
                                        .toDate()
                                        .toString()
                                        .substring(5, 10),
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.favorite_outline,
                                    size: 18,
                                    color: Colors.red,
                                  ),
                                  Text(
                                    geulDocs[index]['likes'].toString(),
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Icon(
                                    Icons.chat_bubble_outline_rounded,
                                    size: 18,
                                  ),
                                  Text(
                                    geulDocs[index]['comments'].toString(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Divider(
                            height: 0.5,
                            color: Palette.color2,
                          ),
                        ],
                      ),
                    );
                  } else if (board == 'hotBoard') {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EachGeul(
                                    board: board,
                                    title: geulDocs[index]['title'],
                                    content: geulDocs[index]['content'],
                                    userName: geulDocs[index]['userName'],
                                    time: geulDocs[index]['time']
                                        .toDate()
                                        .toString()
                                        .substring(0, 19),
                                    docId: docId,
                                    userId: 'IdontCare')));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            geulDocs[index]['title'],
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                geulDocs[index]['time']
                                            .toDate()
                                            .toString()
                                            .substring(0, 9) ==
                                        DateTime.now()
                                            .toString()
                                            .substring(0, 9)
                                    ? geulDocs[index]['time']
                                        .toDate()
                                        .toString()
                                        .substring(11, 16)
                                    : geulDocs[index]['time']
                                        .toDate()
                                        .toString()
                                        .substring(5, 10),
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.favorite_outline,
                                    size: 18,
                                    color: Colors.red,
                                  ),
                                  Text(
                                    geulDocs[index]['likes'].toString(),
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Icon(
                                    Icons.chat_bubble_outline_rounded,
                                    size: 18,
                                  ),
                                  Text(
                                    geulDocs[index]['comments'].toString(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Divider(
                            height: 0.5,
                            color: Palette.color2,
                          ),
                        ],
                      ),
                    );
                  }
                }
                return null;
              });
        },
      ),
    );
  }
}
