import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/data/model/category_model.dart';

abstract class ShowCategoryController extends GetxController {
  // Text controllers
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController visibleController;

  // Methods (abstract)
  initialCategory(CategoryModel category);
}

class ShowCategoryControllerImp extends ShowCategoryController {
  CategoryModel? categoryModel;

  @override
  void onInit() {
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    visibleController = TextEditingController();
    super.onInit();
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
