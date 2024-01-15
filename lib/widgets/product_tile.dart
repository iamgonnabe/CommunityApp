import 'package:flutter/material.dart';
import 'package:flutterproject/controller/controller.dart';
import 'package:flutterproject/models/product_model.dart';
import 'package:flutterproject/screens/each_review_screen.dart';
import 'package:get/get.dart';

class ProductTile extends StatelessWidget {
  final ProductModel product;
  const ProductTile(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Controller());
    return GestureDetector(
      onTap: () {
        Get.to(() => ReviewGeul(product: product));
      },
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Stack(
              children: [
                Container(
                  height: 75,
                  width: 100,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Image.network(
                    product.image,
                    fit: BoxFit.fill,
                  ),
                ),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 15,
                            child: IconButton(
                              padding: const EdgeInsets.only(right: 0),
                              icon: product.like.value
                                  ? const Icon(Icons.favorite_rounded)
                                  : const Icon(Icons.favorite_border),
                              onPressed: () {
                                product.like.toggle();
                                if (product.like.value) {
                                  controller.pluslike(product);
                                } else {
                                  controller.dislike(product);
                                }
                              },
                              iconSize: 18,
                              color: product.like.value
                                  ? Colors.red
                                  : Colors.black,
                            ),
                          ),
                          Text(
                            product.likes.value.toString(),
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              product.title,
              maxLines: 2,
              style: const TextStyle(fontWeight: FontWeight.w400),
              overflow: TextOverflow.ellipsis,
            ),
          ]),
        ),
      ),
    );
  }
}
