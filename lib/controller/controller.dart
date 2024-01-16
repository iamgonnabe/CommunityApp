import 'package:flutterproject/models/product_model.dart';
import 'package:flutterproject/service/api_service.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  var fetching = true.obs;
  var productList = <ProductModel>[].obs;
  late dynamic chicken;
  late dynamic protein;
  late dynamic equipStrap;
  late dynamic equipBelt;
  late dynamic equipArmor;
  var selectedIndex = 0.obs;
  var isLike = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    chicken = await ApiService.fetchProducts('닭가슴살');
    protein = await ApiService.fetchProducts('프로틴');
    equipStrap = await ApiService.fetchProducts('헬스스트랩');
    equipBelt = await ApiService.fetchProducts('헬스벨트');
    equipArmor = await ApiService.fetchProducts('헬스보호대');
    productList.value = chicken;
    fetching.toggle();
  }

  void chooseObject(int value) {
    selectedIndex.value = value;
    if (value == 0) {
      productList.value = chicken;
    } else if (value == 1) {
      productList.value = protein;
    } else if (value == 2) {
      productList.value = equipStrap;
    } else if (value == 3) {
      productList.value = equipBelt;
    } else if (value == 4) {
      productList.value = equipArmor;
    }
  }

  void pluslike(ProductModel product) {
    product.likes++;
  }

  void dislike(ProductModel product) {
    product.likes--;
  }
}
