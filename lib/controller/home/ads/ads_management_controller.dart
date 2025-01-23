import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/core/functions/show_delete_confirmation_dialog.dart';
import 'package:promotion_dashboard/core/functions/snackbar.dart';
import 'package:promotion_dashboard/data/model/general/paganiation_data_model.dart';
import 'package:promotion_dashboard/data/model/home/contacts/contact_model.dart';
import 'package:promotion_dashboard/data/resource/remote/home/contacts_data.dart';
import 'package:promotion_dashboard/view/widgets/home/contacts/contacts_details_dialog.dart';

abstract class AdsManagementController extends GetxController {
  Future<void> getContactsData({required int pageIndex});
  Future<void> deleteContact(int id);
  late TextEditingController searchController;
  void filterContacts(String query);
  showContact(int id);
  Future<void> showCategoryDetailsDialog(int id);
}

class AdsManagementControllerImp extends AdsManagementController {
  ContactsData contactsData = ContactsData();

  List<ContactModel> contacts = [];
  List<ContactModel> filteredContacts = [];

  ContactModel? contactModel;
  late PaganationDataModel paganationDataModel;

  bool loading = false;
  @override
  void onInit() {
    super.onInit();
    searchController = TextEditingController();
    getContactsData(pageIndex: 1);
    filterContacts('');
  }

  @override
  Future<void> getContactsData({required int pageIndex}) async {
    loading = true;
    update();
    var response = await contactsData.get(indexPage: pageIndex);
    if (response.isSuccess) {
      contacts = List.generate(response.data.length,
          (index) => ContactModel.fromJson(response.data[index]));
      paganationDataModel = PaganationDataModel.fromJson(response.body['meta']);
      filterContacts('');
    }
    loading = false;
    update();
  }

  @override
  Future<void> showContact(int id) async {
    loading = true;
    update();
    Get.parameters.clear();
    var response = await contactsData.show(id);
    if (response.isSuccess) {
      contactModel = ContactModel.fromJson(response.data);
    }

    loading = false;
    update();
  }

  @override
  Future<void> showCategoryDetailsDialog(int id) async {
    await showContact(id);
    if (contactModel != null) {
      Get.dialog(
        ContactDetailsDialog(
          contactModel: contactModel!,
        ),
      );
      update();
    } else {
      customSnackBar('Error', 'Category details not found!',
          snackType: SnackBarType.error);
    }
  }

  @override
  Future<void> deleteContact(int id) async {
    showDeleteConfirmationDialog(
      title: 'Delete Confirmation',
      message: 'Are you sure you want to delete this item?',
      onConfirm: () async {
        loading = true;
        update();

        var response = await contactsData.delete(id);

        if (response.isSuccess) {
          getContactsData(pageIndex: paganationDataModel.currentPage);
          customSnackBar(
            response.message!,
            '',
            snackType: SnackBarType.correct,
            snackPosition: SnackBarPosition.topEnd,
          );
          update();
        }

        loading = false;
        update();
      },
    );
  }

  @override
  void filterContacts(String query) {
    searchController.text = query;
    if (query.isEmpty) {
      filteredContacts = contacts;
    } else {
      filteredContacts = contacts
          .where((contact) =>
              contact.name.en.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    update();
  }
}
