import 'package:get/get.dart';
import 'package:promotion_dashboard/core/constants/routes.dart';
import 'package:promotion_dashboard/core/functions/snackbar.dart';
import 'package:promotion_dashboard/data/model/category_model.dart';
import 'package:promotion_dashboard/data/resource/categories_data.dart';

abstract class ProductsManagementController extends GetxController {
  getPCategoriesData();
  Future<void> deleteCategory(int id);
  onPressedAddProduct();
}

class CategoriesManagementControllerImp extends ProductsManagementController {
  bool loading = false;
  @override
  void onInit() {
    super.onInit();
    getPCategoriesData();
  }

  CategoriesData categoriesData = CategoriesData();
  List<CategoryModel>? categories;
  @override
  getPCategoriesData() async {
    loading = true;
    update();
    var response = await categoriesData.get();
    if (response.isSuccess) {
      categories = List.generate(response.data.length,
          (index) => CategoryModel.fromJson(response.data[index]));
    }
    loading = false;
    update();
  }

  @override
  Future<void> deleteCategory(int id) async {
    loading = true;
    update();
    var response = await categoriesData.delete(id);
    if (response.statusCode == 200) {
      getPCategoriesData();
      customSnackBar('', response.message!,
          snackType: SnackBarType.correct,
          snackPosition: SnackBarPosition.topEnd);
      update();
    }
    loading = false;
    update();
  }

  @override
  onPressedAddProduct() async {
    await Get.toNamed(AppRoutes.createCategory);
    getPCategoriesData();
  }
}
