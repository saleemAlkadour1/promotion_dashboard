import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:image_picker/image_picker.dart';
import 'package:promotion_dashboard/core/functions/snackbar.dart';
import 'package:promotion_dashboard/core/localization/changelocale.dart';
import 'package:promotion_dashboard/data/resource/remote/home/contacts_data.dart';

abstract class CreateAdController extends GetxController {
  // Text controllers
  List<TextEditingController> nameController = [];
  late TextEditingController urlController;
  File? image;
  // Methods (abstract)

  Future<void> pickImage();
  Future<void> createContact();
}

class CreateAdControllerImp extends CreateAdController {
  bool loading = false;
  ContactsData contactsData = ContactsData();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  Color selectedColor = Colors.blue;

  @override
  void onInit() {
    urlController = TextEditingController();
    for (var i = 0; i < myLanguages.length; i++) {
      nameController.add(TextEditingController());
    }
    super.onInit();
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
    urlController.clear();
    super.onClose();
  }

  @override
  Future<void> createContact() async {
    String color = '0x${selectedColor.value.toRadixString(16).toUpperCase()}';
    if (!formState.currentState!.validate()) return;
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

    var response = await contactsData.create(
      setValues(nameController),
      urlController.text,
      image!,
      color,
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
}

Map setValues(List<TextEditingController> controllers) {
  Map data = {};

  for (var i = 0; i < myLanguages.length; i++) {
    data[myLanguages.entries.toList()[i].key] = controllers[i].text.trim();
  }

  return data;
}
