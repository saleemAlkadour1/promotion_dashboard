import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/core/functions/show_delete_confirmation_dialog.dart';
import 'package:promotion_dashboard/core/functions/snackbar.dart';
import 'package:promotion_dashboard/data/model/home/categories/category_model.dart';
import 'package:promotion_dashboard/data/resource/remote/home/categories_data.dart';
import 'package:promotion_dashboard/view/widgets/categories/categories_details_dialog.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

abstract class CategoriesManagementController extends GetxController {
  Future<void> getPCategoriesData();
  Future<void> deleteCategory(int id);
  late DataPagerController dataPagerController;
  late TextEditingController searchController;
  showCategory(int id);
}

class CategoriesManagementControllerImp extends CategoriesManagementController {
  List<CategoryModel> filteredCategories = [];

  bool loading = false;
  @override
  void onInit() {
    super.onInit();
    searchController = TextEditingController();
    getPCategoriesData();
    filteredCategories = categories;

    dataPagerController = DataPagerController();
  }

  CategoriesData categoriesData = CategoriesData();
  List<CategoryModel> categories = [];
  CategoryModel? categoryModel;
  @override
  Future<void> getPCategoriesData() async {
    loading = true;
    update();
    var response = await categoriesData.get();
    if (response.isSuccess) {
      categories = List.generate(response.data.length,
          (index) => CategoryModel.fromJson(response.data[index]));
      filteredCategories = categories;
    }
    loading = false;
    update();
  }

  @override
  Future<void> showCategory(int id) async {
    loading = true;
    update();
    Get.parameters.clear();
    var response = await categoriesData.show(id);
    if (response.isSuccess) {
      categoryModel = CategoryModel.fromJson(response.data);
    }

    loading = false;
    update();
  }

  void showCategoryDetailsDialog(int id) async {
    await showCategory(id);
    if (categoryModel != null) {
      Get.dialog(
        CategoryDetailsDialog(
          categoryModel: categoryModel!,
        ),
      );
      update();
    } else {
      customSnackBar('Error', 'Category details not found!',
          snackType: SnackBarType.error);
    }
  }

  @override
  Future<void> deleteCategory(int id) async {
    // Show confirmation dialog
    showDeleteConfirmationDialog(
      title: 'Delete Confirmation',
      message: 'Are you sure you want to delete this item?',
      onConfirm: () async {
        // Execute delete action when confirmed
        loading = true;
        update();

        var response = await categoriesData.delete(id);

        if (response.isSuccess) {
          getPCategoriesData();
          customSnackBar(
            '',
            response.message!,
            snackType: SnackBarType.correct,
            snackPosition: SnackBarPosition.topEnd,
          );
          update();
        }

        loading = false;
        update();
      },
    );
  }

  void filterCategories(String query) {
    searchController.text = query;
    if (query.isEmpty) {
      filteredCategories = categories;
    } else {
      filteredCategories = categories
          .where((category) =>
              category.name.en!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    update();
  }
}
