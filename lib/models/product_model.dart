import 'package:get/get.dart';

class ProductModel {
  final String image, price;
  String title;

  ProductModel.fromJson(Map<String, dynamic> json)
      : title = _processTitle(json['title']),
        image = json['image'],
        price = json['lprice'];

  var like = false.obs;

  static String _processTitle(String rawTitle) {
    String processedTitle = rawTitle.replaceAll("</b>", "");
    processedTitle = processedTitle.replaceAll("<b>", "");
    return processedTitle;
  }
}
