import 'package:get/get.dart';
import 'package:promotion_dashboard/data/model/product2_model.dart';
import 'package:promotion_dashboard/data/model/product_model.dart';
import 'package:promotion_dashboard/data/resource/product_data.dart';

abstract class ProductsManagementController extends GetxController {
  getProductsData();
}

class ProductsManagementControllerImp extends ProductsManagementController {
  @override
  void onInit() {
    super.onInit();
    getProductsData();
  }

  ProductData productData = ProductData();
  List<ProductModel> products = [];

  List<Product2Model> products2 = List.generate(
      50,
      (index) => Product2Model(
          id: index.toString(),
          name: 'Name $index',
          type: 'type $index',
          price: 'Price $index'));

  @override
  getProductsData() async {
    var response = await productData.get();
    if (response.isSuccess) {
      products = List.generate(response.data.length,
          (index) => ProductModel.fromJson(response.data[index]));
    }
    update();
  }
}
