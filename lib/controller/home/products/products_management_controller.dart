import 'package:get/get.dart';
import 'package:promotion_dashboard/core/functions/show_delete_confirmation_dialog.dart';
import 'package:promotion_dashboard/core/functions/snackbar.dart';
import 'package:promotion_dashboard/data/model/home/product_model.dart';
import 'package:promotion_dashboard/data/resource/remote/home/product_data.dart';
import 'package:promotion_dashboard/view/widgets/products/products_details_dialog.dart';

abstract class ProductsManagementController extends GetxController {
  getProductsData();
  Future<void> deleteProduct(int id);
  Future<void> showProduct(int id);
}

class ProductsManagementControllerImp extends ProductsManagementController {
  bool loading = false;
  ProductModel? productModel;
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
      update();
    }
    loading = false;

    update();
  }

  @override
  Future<void> showProduct(int id) async {
    loading = true;
    update();
    Get.parameters.clear();
    var response = await productData.show(id);
    if (response.isSuccess) {
      productModel = ProductModel.fromJson(response.data);
    }

    loading = false;
    update();
  }

  void showProductDetailsDialog(int id) async {
    await showProduct(id);
    if (productModel != null) {
      Get.dialog(
        ProductDetailsDialog(
          productModel: productModel!,
        ),
      );
      update();
    } else {
      customSnackBar('Error', 'Category details not found!',
          snackType: SnackBarType.error);
    }
  }

  @override
  Future<void> deleteProduct(int id) async {
    showDeleteConfirmationDialog(
      title: 'Delete Confirmation',
      message: 'Are you sure you want to delete this item?',
      onConfirm: () async {
        loading = true;
        update();
        var response = await productData.delete(id);
        if (response.isSuccess) {
          getProductsData();
          customSnackBar(
            '',
            response.message!,
            snackType: SnackBarType.correct,
          );
          update();
        }

        loading = false;
        update();
      },
    );
  }
}
