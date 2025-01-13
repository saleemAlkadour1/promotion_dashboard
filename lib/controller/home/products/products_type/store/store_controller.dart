import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:promotion_dashboard/core/functions/snackbar.dart';
import 'package:promotion_dashboard/data/resource/remote/home/product_data.dart';
import 'package:promotion_dashboard/view/widgets/products/products_type/store/create_product_dialog.dart';
import 'package:promotion_dashboard/view/widgets/products/products_type/store/update_product_dialog.dart';

abstract class StoreController extends GetxController {
  late TextEditingController poductIdController;
  late TextEditingController labelController;
  late TextEditingController valueController;
  late TextEditingController updateLabelController;
  late TextEditingController updateValueController;

  int get productId => int.parse(Get.parameters['id'] ?? "0");

  Future<void> createProduct();
  Future<void> deleteProduct(int id);
  void returnToCreateProduct();
  void showCreateProductDialog();
  void addDynamicValue();
  void deleteDynamicValue(int index);
  getStoreItems();
  showProduct();
}

class StoreControllerImp extends StoreController {
  bool loading = false;
  // List<ProductStoreModel>? products;
  List products = [];
  ProductData productData = ProductData();
  List values = [];
  int? updateIndex;
  bool addingNewValue = false;
  int porductStoreId = 0;

  @override
  void onInit() {
    super.onInit();
    poductIdController = TextEditingController();
    labelController = TextEditingController();
    valueController = TextEditingController();
    updateLabelController = TextEditingController();
    updateValueController = TextEditingController();
    getStoreItems();
  }

  @override
  Future<void> getStoreItems() async {
    loading = true;
    update();
    var response = await productData.getStore(productId);
    if (response.isSuccess) {
      products = response.data;
    }
    loading = false;
    update();
  }

  @override
  Future<void> showProduct() async {
    loading = true;
    update();

    loading = false;
    update();
  }

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
        // 'product_items_id': null,
      });
    }

    labelController.clear();
    valueController.clear();
    update();
  }

  @override
  void deleteDynamicValue(int index) {
    values.removeAt(index);
    update();
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
        productId: productId,
        visible: true,
        values: values,
      );
      if (response.isSuccess) {
        await getStoreItems();
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

  //Update
  Future<void> showUpdateProductDialog(int id) async {
    var response = await productData.showProductStore(id);
    if (response.isSuccess) {
      values = response.data['values'];
      porductStoreId = id;
    }
    Get.dialog(const UpdateProductDialog());
  }

  void startEdit(int index) {
    updateIndex = index;
    addingNewValue = false;
    updateLabelController.text = values[index]['label'] ?? '';
    updateValueController.text = values[index]['value'] ?? '';
    update();
  }

  void saveUpdatedValue(int index) {
    if (updateLabelController.text.isNotEmpty &&
        updateValueController.text.isNotEmpty) {
      values[index] = {
        'id': values[index]['id'],
        'label': updateLabelController.text,
        'value': updateValueController.text,
      };
      updateIndex = null;
      update();
    } else {
      customSnackBar(
        'Fill in both fields before saving.',
        '',
        snackType: SnackBarType.error,
      );
    }
  }

  void cancelUpdate() {
    if (addingNewValue) {
      values.removeLast();
      addingNewValue = false;
    }
    updateIndex = null;
    update();
  }

  void deleteUpdateDynamicValue(int index) {
    if (values[index]['id'] != null) {
      values[index]['delete'] = 1;
    } else {
      values.removeAt(index);
    }
    update();
  }

  void startAddingNewValue() {
    addingNewValue = true;
    updateIndex = null;
    updateLabelController.clear();
    updateValueController.clear();
    values.add({'label': '', 'value': ''});
    update();
  }

  void saveNewValue() {
    if (updateLabelController.text.isNotEmpty &&
        updateValueController.text.isNotEmpty) {
      values[values.length - 1] = {
        'label': updateLabelController.text,
        'value': updateValueController.text,
      };
      addingNewValue = false;
      update();
    } else {
      customSnackBar(
        'Please fill in both fields before saving.',
        '',
        snackType: SnackBarType.error,
      );
    }
  }

  Future<void> updateProduct() async {
    loading = true;
    update();
    Get.back();
    var filteredValues = values.map((item) {
      if (item.containsKey('delete') && item['delete'] == 1) {
        return {'id': item['id'], 'delete': 1};
      } else {
        return {
          'id': item['id'],
          'label': item['label'],
          'value': item['value'],
        };
      }
    }).toList();

    var response = await productData.updateStore(
      productId: porductStoreId,
      visible: true,
      values: filteredValues,
    );

    if (response.isSuccess) {
      getStoreItems();
      customSnackBar('', response.message ?? '');
    }
    loading = false;
    update();

    updateLabelController.clear();
    updateValueController.clear();
    values.clear();
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
