import 'dart:convert';

import 'package:flutterproject/models/product_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static var client = http.Client();

  static Future<List<ProductModel>> fetchProducts(String product) async {
    final Map<String, String> headers = {
      'X-Naver-Client-Id': '8WFW72Gai4IQyg4u0GGD',
      'X-Naver-Client-Secret': 'K_fRuW3o5u',
    };
    List<ProductModel> productInstances = [];

    final http.Response response = await client.get(
        Uri.parse(
            'https://openapi.naver.com/v1/search/shop.json?query=$product&display=30'),
        headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> fromMap = jsonDecode(response.body);
      List<dynamic> products = List.from(fromMap["items"]).toList();
      for (var product in products) {
        productInstances.add(ProductModel.fromJson(product));
      }
      return productInstances;
    }
    throw Error();
  }
}
