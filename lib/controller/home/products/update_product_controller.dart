import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:promotion_dashboard/core/functions/snackbar.dart';
import 'package:promotion_dashboard/core/localization/changelocale.dart';
import 'package:promotion_dashboard/data/model/home/categories/category_model.dart';
import 'package:promotion_dashboard/data/resource/remote/home/categories_data.dart';
import 'package:promotion_dashboard/data/resource/remote/home/products_data.dart';

abstract class UpdateProductController extends GetxController {
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
  String typeValue = 'live';
  String numberlyValue = 'Yes';
  String categoryValue = '';
  String sourceValue = 'Internal';

  // Categories data
  List<CategoryModel>? categories;
  List<String> categoriesName = [];

  // Images list
  List<File> selectedImages = [];

  // Methods (abstract)
  void updateVisibleValue(String value);
  void updateTypeValue(String value);
  void updateNumberlyValue(String value);
  void updateSourceValue(String value);
  void updateCategoryValue(String value);
  void updateAvailableValue(String value);
  Future<void> pickImages();
  void removeImage(File image);
  Future<void> getCategoriesData();
  Future<void> updateProuct();
  void cancel();
}

class UpdateProductControllerImp extends UpdateProductController {
  CategoriesData categoriesData = CategoriesData();
  ProductsData productData = ProductsData();
  bool loading = false;
  int categoryId = 0;
  List inputs = [];

  @override
  void onInit() {
    super.onInit();

    getCategoriesData();
    for (var i = 0; i < myLanguages.length; i++) {
      nameController.add(TextEditingController());
      descriptionController.add(TextEditingController());
    }
    purchasePriceController = TextEditingController();
    salePriceController = TextEditingController();
    minController = TextEditingController();
    maxController = TextEditingController();
  }

  @override
  Future<void> getCategoriesData() async {
    loading = true;
    update();

    var response = await categoriesData.get();
    if (response.isSuccess) {
      categories = List.generate(
        response.data.length,
        (index) => CategoryModel.fromJson(response.data[index]),
      );

      if (categories != null) {
        categoriesName =
            categories!.map((category) => category.name.en!).toSet().toList();
      }

      if (!categoriesName.contains(categoryValue)) {
        categoriesName.add(categoryValue);
      }
    }

    loading = false;
    update();
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
  void updateNumberlyValue(String value) {
    numberlyValue = value;
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
    try {
      ImagePicker picker = ImagePicker();

      final List<XFile> images = await picker.pickMultiImage();
      if (images.isNotEmpty) {
        selectedImages.addAll(images.map((image) => File(image.path)).toList());
      } else {
        customSnackBar(
          "إلغاء",
          "لم يتم اختيار أي صورة.",
          snackType: SnackBarType.warning,
        );
      }
    } catch (e) {
      customSnackBar("خطأ", "حدث خطأ أثناء اختيار الصور: $e",
          snackType: SnackBarType.error);
    } finally {
      update();
    }
  }

  @override
  void removeImage(File image) {
    selectedImages.remove(image);
    update();
  }

  @override
  Future<void> updateProuct() async {}

  @override
  void cancel() {}

  @override
  void onClose() {
    super.onClose();
    nameController.clear();
    descriptionController.clear();
    purchasePriceController.dispose();
    salePriceController.dispose();
    minController.dispose();
    maxController.dispose();
    update();
  }
}

Map setValues(List<TextEditingController> controllers) {
  Map data = {};

  for (var i = 0; i < myLanguages.length; i++) {
    data[myLanguages.entries.toList()[i].key] = controllers[i].text.trim();
  }
  return data;
}
