import 'package:flutterproject/models/product_model.dart';
import 'package:flutterproject/service/api_service.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  var chickenList = <ProductModel>[].obs;
  var proteinList = <ProductModel>[].obs;
  var equipList = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    var chicken = await ApiService.fetchProducts('닭가슴살');
    var protein = await ApiService.fetchProducts('프로틴');
    var equip = await ApiService.fetchProducts('헬스장비');

    chickenList.value = chicken;
    proteinList.value = protein;
    equipList.value = equip;
  }
}
