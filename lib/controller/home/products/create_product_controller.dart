import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/core/constants/routes.dart';
import 'package:promotion_dashboard/core/localization/changelocale.dart';
import 'package:promotion_dashboard/data/model/home/category_model.dart';
import 'package:promotion_dashboard/data/resource/remote/home/categories_data.dart';

abstract class CreateProductController extends GetxController {
  // Text controllers
  List<TextEditingController> nameController = [];
  List<TextEditingController> descriptionController = [];
  late TextEditingController purchasePriceController;
  late TextEditingController salePriceController;
  late TextEditingController minController;
  late TextEditingController maxController;

  // Dropdown values
  String visibleValue = 'Yes';
  String availableValue = 'Yes';
  String typeValue = 'Live';
  String categoryValue = 'Live';
  String sourceValue = 'Internal';
  String serverNameValue = 'five_sim';

  // Categories data
  List<CategoryModel>? categories;
  List<String> categoriesName = [];

  // Images list
  List<File> selectedImages = [];

  // Methods (abstract)
  void updateVisibleValue(String value);
  void updateTypeValue(String value);
  void updateSourceValue(String value);
  void updateCategoryValue(String value);
  void updateAvailableValue(String value);
  void updateServerNameValue(String value);
  Future<void> pickImages();
  void removeImage(File image);
  getPCategoriesData();
}

class CreateProductControllerImp extends CreateProductController {
  CategoriesData categoriesData = CategoriesData();
  bool loading = false;
  int categoryId = 0;

  @override
  getPCategoriesData() async {
    loading = true;
    update();

    var response = await categoriesData.get();
    if (response.isSuccess) {
      categories = List.generate(
        response.data.length,
        (index) => CategoryModel.fromJson(response.data[index]),
      );

      // Populate categories names
      if (categories != null) {
        categoriesName =
            categories!.map((category) => category.name.en!).toSet().toList();
      }

      // Ensure the default categoryValue exists in the list
      if (!categoriesName.contains(categoryValue)) {
        categoriesName.add(categoryValue);
      }
    }

    loading = false;
    update();
  }

  @override
  void onInit() {
    getPCategoriesData();
    for (var i = 0; i < myLanguages.length; i++) {
      nameController.add(TextEditingController());
      descriptionController.add(TextEditingController());
    }
    purchasePriceController = TextEditingController();
    salePriceController = TextEditingController();
    minController = TextEditingController();
    maxController = TextEditingController();

    super.onInit();
  }

  @override
  void updateVisibleValue(String value) {
    visibleValue = value;
    update();
  }

  @override
  void updateTypeValue(String value) {
    typeValue = value;
    update();
  }

  @override
  void updateSourceValue(String value) {
    sourceValue = value;
    update();
  }

  @override
  void updateCategoryValue(String value) {
    categoryValue = value;

    for (final category in categories ?? []) {
      if (category.name.en == value) {
        categoryId = category.id;
        break;
      }
    }

    log('Selected Category ID: $categoryId');
    update();
  }

  @override
  void updateAvailableValue(String value) {
    availableValue = value;
  }

  @override
  Future<void> pickImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (result != null) {
      selectedImages.addAll(
        result.paths.where((path) => path != null).map((path) => File(path!)),
      );
      update();
    }
  }

  @override
  void removeImage(File image) {
    selectedImages.remove(image);
    update();
  }

  @override
  void onClose() {
    nameController.clear();
    descriptionController.clear();
    purchasePriceController.dispose();
    salePriceController.dispose();
    minController.dispose();
    maxController.dispose();
    super.onClose();
  }

  @override
  void updateServerNameValue(String value) {
    serverNameValue = value;
  }

  next() {
    if (typeValue == 'Live' && serverNameValue == 'five_sim') {
      Get.toNamed(AppRoutes.selectProduct);
    }
  }
}

Map setValues(List<TextEditingController> controllers) {
  Map data = {};

  for (var i = 0; i < myLanguages.length; i++) {
    data[myLanguages.entries.toList()[i].key] = controllers[i].text.trim();
  }

  return data;
}
