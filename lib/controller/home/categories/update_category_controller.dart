import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:promotion_dashboard/core/functions/snackbar.dart';
import 'package:promotion_dashboard/core/localization/changelocale.dart';
import 'package:promotion_dashboard/data/model/home/categories/category_model.dart';
import 'package:promotion_dashboard/data/resource/remote/home/categories_data.dart';

abstract class UpdateCategoryController extends GetxController {
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

  int categoryId = 0;

  // Methods (abstract)
  void updateDisplayMethodValue(String value);

  void updateVisibleValue(String value);
  void updateAvilableValue(String value);

  Future<void> pickImage();
  initialCategory(CategoryModel category);
  Future<void> updateCategory();
  showCategory();
}

class UpdateCategoryControllerImp extends UpdateCategoryController {
  CategoryModel? categoryModel;
  bool isImageFind = false;
  CategoriesData categoriesData = CategoriesData();
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  void onInit() {
    for (var i = 0; i < myLanguages.length; i++) {
      nameController.add(TextEditingController());
      descriptionController.add(TextEditingController());
    }
    categoryId = int.parse(Get.parameters['category_id'] ?? '0');
    showCategory();

    super.onInit();
  }

  @override
  void showCategory() async {
    loading = true;
    isImageFind = true;
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
  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      update();
    }
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
  void onClose() {
    nameController.clear();
    descriptionController.clear();
    super.onClose();
  }

  @override
  initialCategory(CategoryModel category) {
    categoryModel = category;
    getValues(nameController, category.name.toJson());
    getValues(descriptionController, category.description.toJson());
    displayMethodValue = category.productDisplayMethod ?? 'GridView';
    visibleValue = category.visible == true ? 'Yes' : 'No';
    avilableValue = category.available == true ? 'Yes' : 'No';
    updateVisibleValue(visibleValue);
    updateAvilableValue(avilableValue);
    updateDisplayMethodValue(displayMethodValue);
    update();
  }

  @override
  Future<void> updateCategory() async {
    if (!formState.currentState!.validate()) return;

    if (image == null && isImageFind == false) {
      customSnackBar(
        'Please select an image',
        '',
        snackType: SnackBarType.error,
      );
      return;
    }
    loading = true;
    update();
    File? imageToSend = isImageFind ? null : image;

    // إرسال الطلب
    var response = await categoriesData.update(
      categoryId,
      setValues(nameController),
      setValues(descriptionController),
      displayMethodValue,
      visibleValue == 'Yes' ? true : false,
      avilableValue == 'Yes' ? true : false,
      imageToSend,
    );

    // معالجة الاستجابة
    if (response.isSuccess) {
      Get.back();
      customSnackBar('Success', response.message!,
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

Map getValues(List<TextEditingController> controllers, Map categoryData) {
  Map data = {};

  for (var i = 0; i < myLanguages.length; i++) {
    controllers[i].text =
        categoryData[myLanguages.entries.toList()[i].key] ?? '';
  }

  return data;
}
