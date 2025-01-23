import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:promotion_dashboard/core/functions/snackbar.dart';
import 'package:promotion_dashboard/core/localization/changelocale.dart';
import 'package:promotion_dashboard/data/model/home/contacts/contact_model.dart';
import 'package:promotion_dashboard/data/resource/remote/home/contacts_data.dart';

abstract class UpdateContactController extends GetxController {
  // Text controllers
  List<TextEditingController> nameController = [];
  late TextEditingController urlController;

  File? image;

  Future<void> pickImage();
  initialContact(ContactModel contact);
  Future<void> updateContact();
  showContact();
}

class UpdateContactControllerImp extends UpdateContactController {
  bool loading = false;
  int contactId = 0;

  ContactModel? contactModel;
  bool isImageFind = true;
  ContactsData contactsData = ContactsData();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late Color selectedColor;

  @override
  void onInit() {
    urlController = TextEditingController();

    for (var i = 0; i < myLanguages.length; i++) {
      nameController.add(TextEditingController());
    }
    contactId = int.parse(Get.parameters['contact_id'] ?? '0');
    showContact();
    super.onInit();
  }

  @override
  void showContact() async {
    loading = true;
    update();
    var response = await contactsData.show(contactId);
    if (response.isSuccess) {
      contactModel = ContactModel.fromJson(response.data);
      initialContact(contactModel!);
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
  void onClose() {
    nameController.clear();
    urlController.clear();
    super.onClose();
  }

  @override
  initialContact(ContactModel contact) {
    contactModel = contact;
    getValues(nameController, contact.name.toJson());
    urlController.text = contact.url;
    selectedColor = Color(int.tryParse(contact.color)!);
    update();
  }

  @override
  Future<void> updateContact() async {
    String color = '0x${selectedColor.value.toRadixString(16).toUpperCase()}';

    if (!formState.currentState!.validate()) return;

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

    var response = await contactsData.update(
      contactId,
      setValues(nameController),
      urlController.text,
      imageToSend,
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

Map getValues(List<TextEditingController> controllers, Map categoryData) {
  Map data = {};

  for (var i = 0; i < myLanguages.length; i++) {
    controllers[i].text =
        categoryData[myLanguages.entries.toList()[i].key] ?? '';
  }

  return data;
}
