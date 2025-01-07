import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ProductController extends GetxController {
  // Text controllers
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController purchasePriceController;
  late TextEditingController salePriceController;
  late TextEditingController minController;
  late TextEditingController maxController;

  // Dropdown values
  String visibleValue = 'Yes';
  String typeValue = 'Live';
  String sourceValue = 'Internal';

  // Images list
  List<File> selectedImages = [];

  // Methods (abstract)
  void updateVisibleValue(String value);
  void updateTypeValue(String value);
  void updateSourceValue(String value);
  Future<void> pickImages();
  void removeImage(File image);
}

class ProductControllerImp extends ProductController {
  // Initialize text controllers
  @override
  void onInit() {
    nameController = TextEditingController();
    descriptionController = TextEditingController();
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
    purchasePriceController.dispose();
    salePriceController.dispose();
    minController.dispose();
    maxController.dispose();
    super.onClose();
  }
}
