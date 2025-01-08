import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:promotion_dashboard/controller/categories/categories_management_controller.dart';
import 'package:promotion_dashboard/core/functions/snackbar.dart';
import 'package:promotion_dashboard/data/model/category_model.dart';
import 'package:promotion_dashboard/data/resource/categories_data.dart';

abstract class UpdateCategoryController extends GetxController {
  // Text controllers
  late TextEditingController nameController;
  late TextEditingController descriptionController;

  // Dropdown values
  String visibleValue = 'Yes';

  // Images list
  List<File> selectedImages = [];
  bool loading = false;

  // Methods (abstract)
  void updateVisibleValue(String value);
  Future<void> pickImages();
  void removeImage(File image);
  initialCategory(CategoryModel category);
  Future<void> updateCategory(int id);
}

class UpdateCategoryControllerImp extends UpdateCategoryController {
  late CategoryModel categoryModel;

  CategoriesData categoriesData = CategoriesData();

  @override
  void onInit() {
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    super.onInit();
  }

  @override
  void updateVisibleValue(String value) {
    visibleValue = value;
    update();
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
    nameController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  @override
  Future<void> updateCategory(int id) async {
    loading = true;
    update();
    // إعداد الحقول النصية
    String nameEn = nameController.text.trim();
    String descriptionEn = descriptionController.text.trim();

    // تحقق من الحقول المطلوبة
    if (nameEn.isEmpty) {
      Get.snackbar(
        'Error',
        // 'Please fill all fields and select at least one image.',
        'Please fill all fields.',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }
    // تحضير الملفات للرفع
    // List<MultipartFile> multipartImages = [];
    // for (var image in selectedImages) {
    //   multipartImages.add(await MultipartFile.fromFile(
    //     image.path,
    //     filename: image.path.split('/').last,
    //   ));
    // }

    // إرسال الطلب
    var response = await categoriesData.updateCategory(id, {
      'name[en]': nameEn,
      'name[ar]': '',
      'description[en]': descriptionEn,
      'description[ar]': '',
      'visible': visibleValue == 'Yes' ? 1 : 0,
      'product_display_method': 'GridView',
    });

    // معالجة الاستجابة
    if (response.statusCode == 200) {
      customSnackBar(
        'Success',
        'Edited successfully',
        snackType: SnackBarType.correct,
        snackPosition: SnackPosition.TOP,
      );
      // تحديث بيانات CategoriesManagementControllerImp
      CategoriesManagementControllerImp controller =
          Get.find<CategoriesManagementControllerImp>();
      await controller.getPCategoriesData();
      update();
    } else {
      //TODO: To solve problem show snack bar hree later
      loading = false;
      update();
      customSnackBar(
        'Error',
        response.message!,
        snackType: SnackBarType.error,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  @override
  initialCategory(CategoryModel category) {
    categoryModel = category;
    nameController.text = category.name.en!;
    descriptionController.text = category.description.en!;
    visibleValue = category.visible == true ? 'Yes' : 'No';
    updateVisibleValue(visibleValue);
    update();
  }
}
