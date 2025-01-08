import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:image_picker/image_picker.dart';
import 'package:promotion_dashboard/core/functions/snackbar.dart';
import 'package:promotion_dashboard/core/localization/changelocale.dart';
import 'package:promotion_dashboard/data/resource/categories_data.dart';

abstract class CreateCategoryController extends GetxController {
  // Text controllers
  List<TextEditingController> nameController = [];
  List<TextEditingController> descriptionController = [];

  // Dropdown values
  String visibleValue = 'Yes';

  // Images list
  File? image;
  bool loading = false;

  // Methods (abstract)
  void updateVisibleValue(String value);
  Future<void> pickImage();
  Future<void> addCategory();
}

class CreateCategoryControllerImp extends CreateCategoryController {
  CategoriesData categoriesData = CategoriesData();

  @override
  void onInit() {
    for (var i = 0; i < myLanguages.length; i++) {
      nameController.add(TextEditingController());
      descriptionController.add(TextEditingController());
    }
    super.onInit();
  }

  @override
  void updateVisibleValue(String value) {
    visibleValue = value;
    update();
  }

  @override
  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      update();
    }
  }

  // Future<void> pickImagesFromGallery() async {
  //   try {
  //     final List<XFile> images = await picker.pickMultiImage();

  //     if (images.isNotEmpty) {
  //       selectedImages.addAll(images.map((image) => File(image.path)).toList());
  //     } else {
  //       Get.snackbar("إلغاء", "لم يتم اختيار أي صورة.", backgroundColor: Colors.orange, colorText: Colors.white);
  //     }
  //   } catch (e) {
  //     Get.snackbar("خطأ", "حدث خطأ أثناء اختيار الصور: $e", backgroundColor: Colors.red, colorText: Colors.white);
  //   } finally {
  //     update();
  //   }
  // }

  // Future<void> pickImagesFromCamera() async {
  //   try {
  //     final XFile? image = await picker.pickImage(source: ImageSource.camera);

  //     if (image != null) {
  //       selectedImages.add(File(image.path));
  //     } else {
  //       Get.snackbar("إلغاء", "لم يتم التقاط أي صورة.", backgroundColor: Colors.orange, colorText: Colors.white);
  //     }
  //   } catch (e) {
  //     Get.snackbar("خطأ", "حدث خطأ أثناء التقاط الصورة: $e", backgroundColor: Colors.red, colorText: Colors.white);
  //   } finally {
  //     update();
  //   }
  // }

  @override
  void onClose() {
    nameController.clear();
    descriptionController.clear();
    super.onClose();
  }

  @override
  Future<void> addCategory() async {
    if (image == null) {
      customSnackBar(
        'Please select an image',
        '',
        snackType: SnackBarType.error,
      );
      return;
    }
    loading = true;
    update();

    // إرسال الطلب
    var response = await categoriesData.create(
      setValues(nameController),
      setValues(descriptionController),
      'GridView',
      visibleValue == 'Yes',
      true,
      image!,
    );

    // معالجة الاستجابة
    if (response.isSuccess) {
      Get.back();
      customSnackBar('Success', 'Added successfully',
          snackType: SnackBarType.correct,
          snackPosition: SnackBarPosition.topEnd);
    }

    loading = false;
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
