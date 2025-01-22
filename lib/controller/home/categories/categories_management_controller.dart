import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/core/functions/show_delete_confirmation_dialog.dart';
import 'package:promotion_dashboard/core/functions/snackbar.dart';
import 'package:promotion_dashboard/data/model/general/paganiation_data_model.dart';
import 'package:promotion_dashboard/data/model/home/categories/category_model.dart';
import 'package:promotion_dashboard/data/resource/remote/home/categories_data.dart';
import 'package:promotion_dashboard/view/widgets/categories/categories_details_dialog.dart';

abstract class CategoriesManagementController extends GetxController {
  Future<void> getCategoriesData({required int pageIndex});
  Future<void> deleteCategory(int id);
  late TextEditingController searchController;
  showCategory(int id);
}

class CategoriesManagementControllerImp extends CategoriesManagementController {
  CategoriesData categoriesData = CategoriesData();

  List<CategoryModel> categories = [];
  List<CategoryModel> filteredCategories = [];

  CategoryModel? categoryModel;
  late PaganationDataModel paganationDataModel;

  bool loading = false;
  @override
  void onInit() {
    super.onInit();
    searchController = TextEditingController();
    getCategoriesData(pageIndex: 1);
    filterCategories('');
  }

  @override
  Future<void> getCategoriesData({required int pageIndex}) async {
    loading = true;
    update();
    var response = await categoriesData.get(indexPage: pageIndex);
    if (response.isSuccess) {
      categories = List.generate(response.data.length,
          (index) => CategoryModel.fromJson(response.data[index]));
      paganationDataModel = PaganationDataModel.fromJson(response.body['meta']);
      filterCategories('');
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
    showDeleteConfirmationDialog(
      title: 'Delete Confirmation',
      message: 'Are you sure you want to delete this item?',
      onConfirm: () async {
        loading = true;
        update();

        var response = await categoriesData.delete(id);

        if (response.isSuccess) {
          getCategoriesData(pageIndex: paganationDataModel.currentPage);
          customSnackBar(
            response.message!,
            '',
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
