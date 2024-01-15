import 'package:flutter/material.dart';
import 'package:flutterproject/Board/palette.dart';
import 'package:flutterproject/controller/controller.dart';
import 'package:flutterproject/widgets/product_tile.dart';
import 'package:get/get.dart';

class ReviewBoard extends StatefulWidget {
  const ReviewBoard({super.key});

  @override
  State<ReviewBoard> createState() => _ReviewBoardState();
}

class _ReviewBoardState extends State<ReviewBoard> {
  final controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '리뷰 게시판',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Palette.color1,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            const Divider(
              height: 1,
              color: Colors.black,
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Palette.color7,
                    Palette.color1,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        controller.chooseObject(0);
                      },
                      child: const Text(
                        '닭가슴살',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 30,
                    color: Colors.black,
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        controller.chooseObject(1);
                      },
                      child: const Text(
                        '프로틴',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 30,
                    color: Colors.black,
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        controller.chooseObject(2);
                      },
                      child: const Text(
                        '장비',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 1,
              color: Colors.black,
            ),
            Obx(
              () => controller.selectedIndex.value < 2
                  ? const SizedBox(
                      height: 8,
                    )
                  : const SizedBox(
                      height: 0,
                    ),
            ),
            Obx(
              () => controller.selectedIndex.value >= 2
                  ? Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white,
                            Colors.grey.withOpacity(0.7),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomLeft,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    controller.chooseObject(2);
                                  },
                                  child: const Text(
                                    '스트랩',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                              Container(
                                width: 1,
                                height: 15,
                                color: Colors.black,
                              ),
                              TextButton(
                                  onPressed: () {
                                    controller.chooseObject(3);
                                  },
                                  child: const Text(
                                    '벨트',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                              Container(
                                width: 1,
                                height: 15,
                                color: Colors.black,
                              ),
                              TextButton(
                                  onPressed: () {
                                    controller.chooseObject(4);
                                  },
                                  child: const Text(
                                    '보호대',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                            ],
                          ),
                          const Divider(
                            height: 1,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ),
            Obx(
              () => controller.fetching.value
                  ? const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      ),
                    )
                  : Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10),
                          itemBuilder: (context, index) {
                            return ProductTile(controller.productList[index]);
                          },
                          itemCount: controller.productList.length,
                        ),
                      ),
                    ),
            ),
            const SizedBox(
              height: 8,
            )
          ],
        ),
      ),
    );
  }
}
