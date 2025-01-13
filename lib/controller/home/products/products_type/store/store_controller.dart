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
  int? productId;

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
    // استدعاء البيانات من API وإظهارها في واجهة التعديل
    var response = await productData.showProductStore(id);
    if (response.isSuccess) {
      values = response.data['values'];
      productId = id;
    }
    Get.dialog(const UpdateProductDialog());
  }

  void startEdit(int index) {
    // بدء التعديل على قيمة موجودة
    editingIndex = index;
    addingNewValue = false;
    editLabelController.text = values[index]['label'] ?? '';
    editValueController.text = values[index]['value'] ?? '';
    update();
  }

  void saveEditedValue(int index) {
    // حفظ القيمة المعدلة محليًا
    if (editLabelController.text.isNotEmpty &&
        editValueController.text.isNotEmpty) {
      values[index] = {
        'id': values[index]['id'], // الحفاظ على الـ ID إذا كانت القيمة موجودة
        'label': editLabelController.text,
        'value': editValueController.text,
      };
      editingIndex = null;
      update();
    } else {
      customSnackBar(
        '',
        'Fill in both fields before saving.',
        snackType: SnackBarType.error,
      );
    }
  }

  void cancelEdit() {
    // إلغاء عملية التعديل
    if (addingNewValue) {
      values.removeLast();
      addingNewValue = false;
    }
    editingIndex = null;
    update();
  }

  void deleteUpdateDynamicValue(int index) {
    // وضع علامة حذف على العنصر بدلاً من حذفه مباشرةً
    if (values[index]['id'] != null) {
      values[index]['delete'] = 1;
    } else {
      values.removeAt(index); // إذا كانت قيمة جديدة لم تحفظ  احذفها نهائيًا
    }
    update();
  }

  void startAddingNewValue() {
    // إضافة قيمة جديدة
    addingNewValue = true;
    editingIndex = null;
    editLabelController.clear();
    editValueController.clear();
    values.add({'label': '', 'value': ''}); // إضافة عنصر جديد بقيمة فارغة
    update();
  }

  void saveNewValue() {
    // حفظ القيمة الجديدة محليًا
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

  Future<void> updateProduct() async {
    // إرسال البيانات المعدلة إلى API
    loading = true;
    update();
    Get.back();

    var filteredValues = values.map((item) {
      // تصفية العناصر الفارغة
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
      productId: productId!,
      visible: true,
      values: filteredValues,
    );

    if (response.isSuccess) {
      getStore(); // تحديث البيانات المحلية
      customSnackBar('', response.message ?? '');
    }
    loading = false;
    update();

    // إعادة تعيين الحقول
    editLabelController.clear();
    editValueController.clear();
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
