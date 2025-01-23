import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:promotion_dashboard/core/functions/format_date.dart';
import 'package:promotion_dashboard/core/functions/snackbar.dart';
import 'package:promotion_dashboard/core/localization/changelocale.dart';
import 'package:promotion_dashboard/data/model/home/ads/ad_model.dart';
import 'package:promotion_dashboard/data/resource/remote/home/ads_data.dart';

abstract class UpdateAdController extends GetxController {
  bool activeValue = false;

  late TextEditingController linkUrlController;
  late TextEditingController startDateController;
  late TextEditingController endDateController;

  File? image;
  showAd();
  initialAd(AdModel ad);
  Future<void> updateAd();
  void toggleActive(bool? value);

  Future<void> pickImage();
}

class UpdateAdControllerImp extends UpdateAdController {
  bool loading = false;
  int adId = 0;

  AdModel? adModel;
  bool isImageFind = true;
  AdsData adsData = AdsData();
  DateTime? startDate;
  DateTime? endDate;
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  void onInit() {
    linkUrlController = TextEditingController();
    startDateController = TextEditingController();
    endDateController = TextEditingController();
    adId = int.parse(Get.parameters['ad_id'] ?? '0');
    showAd();
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
  void showAd() async {
    loading = true;
    update();
    var response = await adsData.show(adId);
    if (response.isSuccess) {
      adModel = AdModel.fromJson(response.data);
      initialAd(adModel!);
    }
    loading = false;
    update();
  }

  @override
  initialAd(AdModel ad) {
    adModel = ad;
    startDateController.text = formatDate(ad.startDate.toString());
    endDateController.text = formatDate(ad.endDate.toString());
    toggleActive(ad.isActive);
    linkUrlController.text = ad.linkUrl ?? 'No link url';
    update();
  }

  @override
  Future<void> updateAd() async {
    if (!formState.currentState!.validate()) return;
    startDate = DateFormat('dd-MM-yyyy').parse(startDateController.text);
    endDate = DateFormat('dd-MM-yyyy').parse(endDateController.text);
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
    if (image == null && isImageFind == false) {
      customSnackBar(
        'Please select an image',
        '',
        snackType: SnackBarType.error,
      );
      return;
    }
    File? imageToSend = isImageFind ? null : image;
    loading = true;
    update();
    var response = await adsData.update(
      adId,
      imageToSend,
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

Map getValues(List<TextEditingController> controllers, Map categoryData) {
  Map data = {};

  for (var i = 0; i < myLanguages.length; i++) {
    controllers[i].text =
        categoryData[myLanguages.entries.toList()[i].key] ?? '';
  }

  return data;
}
