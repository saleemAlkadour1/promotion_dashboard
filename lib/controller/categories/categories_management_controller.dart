import 'package:get/get.dart';
import 'package:promotion_dashboard/core/functions/snackbar.dart';
import 'package:promotion_dashboard/data/model/category_model.dart';
import 'package:promotion_dashboard/data/resource/categories_data.dart';

abstract class ProductsManagementController extends GetxController {
  getPCategoriesData();
  Future<void> deleteCategory(int id);
}

class CategoriesManagementControllerImp extends ProductsManagementController {
  bool loading = false;
  @override
  void onInit() {
    super.onInit();
    getPCategoriesData();
  }

  CategoriesData categoriesData = CategoriesData();
  List<CategoryModel> categories = [];
  @override
  getPCategoriesData() async {
    loading = true;
    update();
    var response = await categoriesData.getCategories();
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
    var response = await categoriesData.deleteCategory(id);
    if (response.statusCode == 200) {
      getPCategoriesData();
      customSnackBar(
        '',
        'Deleted successfully',
        snackType: SnackBarType.correct,
        snackPosition: SnackPosition.TOP,
      );
      update();
    } else {
      customSnackBar(
        '',
        response.message!,
        snackType: SnackBarType.error,
        snackPosition: SnackPosition.TOP,
      );
      loading = false;
      update();
    }
  }
}