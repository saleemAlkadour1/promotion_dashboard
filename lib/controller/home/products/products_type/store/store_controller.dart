import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:promotion_dashboard/core/functions/snackbar.dart';
import 'package:promotion_dashboard/data/model/home/products/products_type/store/product_store_model.dart';
import 'package:promotion_dashboard/data/resource/remote/home/product_data.dart';
import 'package:promotion_dashboard/view/widgets/products/products_type/store/create_product_dialog.dart';
import 'package:promotion_dashboard/view/widgets/products/products_type/store/update_product_dialog.dart';

abstract class StoreController extends GetxController {
  late TextEditingController poductIdController;
  late TextEditingController labelController;
  late TextEditingController valueController;
  late TextEditingController editLabelController;
  late TextEditingController editValueController;

  Future<void> createProduct();
  Future<void> deleteProduct(int id);
  void returnToCreateProduct();
  void showCreateProductDialog();
  void addDynamicValue();
  void deleteDynamicValue(int index);
}

class StoreControllerImp extends StoreController {
  bool loading = false;
  List<ProductStoreModel>? products;
  ProductData productData = ProductData();

  List values = [];
  int? editingIndex;
  bool addingNewValue = false;

  @override
  void onInit() {
    super.onInit();
    poductIdController = TextEditingController();
    labelController = TextEditingController();
    valueController = TextEditingController();
    editLabelController = TextEditingController();
    editValueController = TextEditingController();
    getStore();
  }

  Future<void> getStore() async {
    loading = true;
    update();
    var response = await productData.getStore();
    if (response.isSuccess) {
      products = List.generate(response.data.length,
          (index) => ProductStoreModel.fromJson(response.data[index]));
    }
    loading = false;
    update();
  }

  Future<void> showProduct() async {
    loading = true;
    update();

    loading = false;
    update();
  }

  // استدعاء تصميم الـ Dialog
  @override
  void showCreateProductDialog() {
    Get.dialog(const CreateProductDialog());
  }

  @override
  void addDynamicValue() {
    if (labelController.text.isEmpty || valueController.text.isEmpty) {
      customSnackBar('Error', 'Please fill in all fields',
          snackType: SnackBarType.error);
      return;
    } else {
      values.add({
        'label': labelController.text,
        'value': valueController.text,
        'id': null,
        'product_items_id': null,
      });
    }

    labelController.clear();
    valueController.clear();
    update();
  }

  @override
  void deleteDynamicValue(int index) {
    if (index >= 0 && index < values.length) {
      values.removeAt(index);
      update();
    }
  }

  @override
  Future<void> createProduct() async {
    if (values.isEmpty) {
      customSnackBar('Error', 'Please fill in all fields',
          snackType: SnackBarType.error);
    } else {
      loading = true;
      update();
      Get.back();

      var response = await productData.createStore(
        productId: 1,
        visible: true,
        values: values,
      );
      if (response.isSuccess) {
        await getStore();
        customSnackBar('', response.message ?? '',
            snackType: SnackBarType.correct);
      }
      loading = false;
      update();
    }
    values.clear();
  }

  @override
  Future<void> deleteProduct(
    int id,
  ) async {
    loading = true;
    update();
    var response = await productData.deleteStore(id);
    if (response.isSuccess) {
      customSnackBar('', response.message ?? '',
          snackType: SnackBarType.correct);
    }
    loading = false;
    update();
  }

  //Edit
  Future<void> showUpdateProductDialog(int id) async {
    var response = await productData.showProductStore(id);
    if (response.isSuccess) {
      values = response.data['values'];
    }
    Get.dialog(const UpdateProductDialog());
  }

  void startEdit(int index) {
    editingIndex = index;
    addingNewValue = false;
    editLabelController.text = values[index]['label'] ?? '';
    editValueController.text = values[index]['value'] ?? '';
    update();
  }

  void saveEditedValue(int index) {
    if (editLabelController.text.isNotEmpty &&
        editValueController.text.isNotEmpty) {
      values[index] = {
        'label': editLabelController.text,
        'value': editValueController.text,
      };
      editingIndex = null;
      update();
    } else {
      customSnackBar(
        '',
        'Please fill in both fields before saving.',
        snackType: SnackBarType.error,
      );
    }
  }

  void cancelEdit() {
    if (addingNewValue) {
      values.removeLast();
      addingNewValue = false;
    }
    editingIndex = null;
    update();
  }

  void deleteDeleteDynamicValue(int index) {
    values.removeAt(index);
    update();
  }

  void startAddingNewValue() {
    addingNewValue = true;
    editingIndex = null;
    editLabelController.clear();
    editValueController.clear();
    values.add({'label': '', 'value': ''});
    update();
  }

  void saveNewValue() {
    if (editLabelController.text.isNotEmpty &&
        editValueController.text.isNotEmpty) {
      values[values.length - 1] = {
        'label': editLabelController.text,
        'value': editValueController.text,
      };
      addingNewValue = false;
      update();
    } else {
      customSnackBar(
        '',
        'Please fill in both fields before saving.',
        snackType: SnackBarType.error,
      );
    }
  }

  void saveChanges() {
    // Send updated values to the API
    print('Sending updated values: $values');
    // Call your API function here
  }

  @override
  void returnToCreateProduct() {
    labelController.clear();
    valueController.clear();
    values.clear();
  }

  @override
  void onClose() {
    poductIdController.dispose();
    labelController.dispose();
    valueController.dispose();
    super.onClose();
  }
}
