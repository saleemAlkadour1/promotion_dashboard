import 'package:get/get.dart';
import 'package:promotion_dashboard/data/model/product_model.dart';

abstract class ProductsController extends GetxController {}

class ProductsControllerImp extends ProductsController {
  List<ProductModel> products = List.generate(
      50,
      (index) => ProductModel(
          id: index.toString(),
          name: 'Name $index',
          type: 'type $index',
          price: 'Price $index'));
}
