import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:promotion_dashboard/controller/categories/categories_management_controller.dart';
import 'package:promotion_dashboard/core/functions/snackbar.dart';
import 'package:promotion_dashboard/data/resource/categories_data.dart';

abstract class CategoryController extends GetxController {
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
  Future<void> addCategory();
}

class CategoryControllerImp extends CategoryController {
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
  Future<void> addCategory() async {
    loading = true;
    update();
    // إعداد الحقول النصية
    String nameEn = nameController.text.trim();
    String descriptionEn = descriptionController.text.trim();

    // تحقق من الحقول المطلوبة
    if (nameEn.isEmpty || selectedImages.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all fields and select at least one image.',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }
    // تحضير الملفات للرفع
    List<MultipartFile> multipartImages = [];
    for (var image in selectedImages) {
      multipartImages.add(await MultipartFile.fromFile(
        image.path,
        filename: image.path.split('/').last,
      ));
    }

    // إرسال الطلب
    var response = await categoriesData.createCategory({
      'name[en]': nameEn,
      'name[ar]': '',
      'description[en]': descriptionEn,
      'description[ar]': '',
      'visible': visibleValue == 'Yes' ? 1 : 0,
      'product_display_method': 'GridView',
      'image': multipartImages,
    });

    // معالجة الاستجابة
    if (response.statusCode == 200) {
      customSnackBar(
        'Success',
        'Added successfully',
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
}
