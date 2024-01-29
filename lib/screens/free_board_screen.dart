import 'package:flutter/material.dart';
import 'package:flutterproject/Board/geul/geul.dart';
import 'package:flutterproject/Board/geul/new_or_edit_geul.dart';
import 'package:flutterproject/main.dart';
import 'package:flutterproject/widgets/login_alarm_widget.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class FreeBoard extends StatefulWidget {
  const FreeBoard({super.key});

  @override
  State<FreeBoard> createState() => _FreeBoardState();
}

class _FreeBoardState extends State<FreeBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('자유게시판'),
      ),
      body: Stack(
        children: [
          const Column(children: [
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: Geul(
              board: 'freeBoard',
            )),
          ]),
          Positioned(
            right: 135,
            left: 135,
            bottom: 50,
            child: ElevatedButton(
                onPressed: () {
                  if (Provider.of<AppUser>(context, listen: false).user !=
                      null) {
                    Get.to(() => const NewOrEditGeul(
<<<<<<< HEAD
=======
                          board: 'freeBoard',
>>>>>>> origin/main
                          title: "",
                          content: "",
                          docId: "",
                          isEdit: false,
                        ));
                  } else {
                    Get.to(() => const LoginAlarm());
                  }
                },
                child: const Text('글쓰기')),
          ),
        ],
      ),
    );
  }
}
