import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/data/model/home/category_model.dart';
import 'package:promotion_dashboard/data/resource/remote/home/categories_data.dart';

abstract class ShowCategoryController extends GetxController {
  // Text controllers
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController visibleController;

  // Methods (abstract)
  initialCategory(CategoryModel category);
  showCategory();
}

class ShowCategoryControllerImp extends ShowCategoryController {
  CategoryModel? categoryModel;
  int categoryId = 0;
  bool loading = false;
  CategoriesData categoriesData = CategoriesData();

  @override
  void onInit() {
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    visibleController = TextEditingController();
    categoryId = int.parse(Get.parameters['category_id'] ?? '0');
    showCategory();
    super.onInit();
  }

  @override
  void showCategory() async {
    loading = true;
    update();
    var response = await categoriesData.show(categoryId);
    if (response.isSuccess) {
      categoryModel = CategoryModel.fromJson(response.data);
      initialCategory(categoryModel!);
    }
    loading = false;
    update();
  }

  @override
  initialCategory(CategoryModel category) {
    categoryModel = category;
    nameController.text = category.name.en!;
    descriptionController.text = category.description.en!;
    visibleController.text = category.visible.toString();
    update();
  }

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    visibleController.dispose();
    super.onClose();
  }
}
