import 'package:get/get.dart';
import 'package:promotion_dashboard/data/model/home/product_model.dart';
import 'package:promotion_dashboard/data/resource/remote/home/product_data.dart';

abstract class ProductsManagementController extends GetxController {
  getProductsData();
}

class ProductsManagementControllerImp extends ProductsManagementController {
  bool loading = false;
  @override
  void onInit() {
    super.onInit();
    getProductsData();
  }

  ProductData productData = ProductData();
  List<ProductModel>? products;
  @override
  getProductsData() async {
    loading = true;
    update();
    var response = await productData.get();
    if (response.isSuccess) {
      products = List.generate(response.data.length,
          (index) => ProductModel.fromJson(response.data[index]));
    }
    loading = false;

    update();
  }
}
