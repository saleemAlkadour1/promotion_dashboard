import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/products/products_management_controller.dart';
import 'package:promotion_dashboard/data/model/product_model.dart';

abstract class SfDataGridProductsController extends GetxController {}

class SfDataGridProductsControllerImp extends SfDataGridProductsController {
  late final List<ProductModel> products;

  @override
  void onInit() {
    super.onInit();
    var productsController = Get.find<ProductsManagementControllerImp>();
    products = productsController.products;
  }
}
