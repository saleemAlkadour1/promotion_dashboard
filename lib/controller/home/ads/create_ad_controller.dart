import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:promotion_dashboard/core/functions/snackbar.dart';
import 'package:promotion_dashboard/core/localization/changelocale.dart';
import 'package:promotion_dashboard/data/resource/remote/home/ads_data.dart';

abstract class CreateAdController extends GetxController {
  bool activeValue = false;

  // Text controllers
  late TextEditingController linkUrlController;
  late TextEditingController startDateController;
  late TextEditingController endDateController;
  File? image;
  // Methods
  void toggleActive(bool? value);
  Future<void> pickImage();
  Future<void> createAd();
}

class CreateAdControllerImp extends CreateAdController {
  bool loading = false;

  AdsData adsData = AdsData();
  DateTime? startDate;
  DateTime? endDate;
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  void onInit() {
    linkUrlController = TextEditingController();
    startDateController = TextEditingController();
    endDateController = TextEditingController();

    super.onInit();
  }

  @override
  void toggleActive(bool? value) {
    activeValue = value ?? false;
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
  Future<void> createAd() async {
    startDate = DateTime.parse(startDateController.text);
    endDate = DateTime.parse(endDateController.text);
    if (!formState.currentState!.validate()) return;
    if (startDate != null && endDate != null) {
      if (endDate!.isBefore(startDate!)) {
        customSnackBar(
          'Invalid Dates',
          'The end date must be after the start date.',
          snackType: SnackBarType.error,
        );
        return;
      }
    }
    if (image == null) {
      customSnackBar(
        'Error',
        'Please select an image',
        snackType: SnackBarType.error,
      );
      return;
    }
    loading = true;
    update();

    var response = await adsData.create(
      image!,
      startDateController.text,
      endDateController.text,
      activeValue,
      linkUrlController.text,
    );

    if (response.isSuccess) {
      Get.back();
      customSnackBar(
        response.message!,
        '',
        snackType: SnackBarType.correct,
      );
    }

    loading = false;
    update();
  }

  @override
  void onClose() {
    startDateController.clear();
    endDateController.clear();
    linkUrlController.clear();
    super.onClose();
  }
}

Map setValues(List<TextEditingController> controllers) {
  Map data = {};

  for (var i = 0; i < myLanguages.length; i++) {
    data[myLanguages.entries.toList()[i].key] = controllers[i].text.trim();
  }

  return data;
}
