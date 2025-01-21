import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:image_picker/image_picker.dart';
import 'package:promotion_dashboard/core/functions/snackbar.dart';
import 'package:promotion_dashboard/core/localization/changelocale.dart';
import 'package:promotion_dashboard/data/resource/remote/home/categories_data.dart';

abstract class CreateCategoryController extends GetxController {
  // Text controllers
  List<TextEditingController> nameController = [];
  List<TextEditingController> descriptionController = [];

  // Dropdown values
  String displayMethodValue = 'GridView';

  String visibleValue = 'Yes';
  String avilableValue = 'Yes';

  // Images list
  File? image;
  bool loading = false;

  // Methods (abstract)
  void updateDisplayMethodValue(String value);
  void updateVisibleValue(String value);
  void updateAvilableValue(String value);
  Future<void> pickImage();
  Future<void> addCategory();
}

class CreateCategoryControllerImp extends CreateCategoryController {
  CategoriesData categoriesData = CategoriesData();
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  void onInit() {
    for (var i = 0; i < myLanguages.length; i++) {
      nameController.add(TextEditingController());
      descriptionController.add(TextEditingController());
    }
    super.onInit();
  }

  @override
  void updateDisplayMethodValue(String value) {
    displayMethodValue = value;
    update();
  }

  @override
  void updateVisibleValue(String value) {
    visibleValue = value;
    update();
  }

  @override
  void updateAvilableValue(String value) {
    avilableValue = value;
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

  @override
  void onClose() {
    nameController.clear();
    descriptionController.clear();
    super.onClose();
  }

  @override
  Future<void> addCategory() async {
    if (!formState.currentState!.validate()) return;
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

    var response = await categoriesData.create(
      setValues(nameController),
      setValues(descriptionController),
      displayMethodValue,
      visibleValue == 'Yes' ? true : false,
      avilableValue == 'Yes' ? true : false,
      image!,
    );

    // معالجة الاستجابة
    if (response.isSuccess) {
      Get.back();
      customSnackBar(
        'Success',
        response.message!,
        snackType: SnackBarType.correct,
      );
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
