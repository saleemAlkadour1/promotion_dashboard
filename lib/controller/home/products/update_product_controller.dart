import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:promotion_dashboard/core/functions/snackbar.dart';
import 'package:promotion_dashboard/core/localization/changelocale.dart';
import 'package:promotion_dashboard/data/model/home/categories/category_model.dart';
import 'package:promotion_dashboard/data/model/home/products/product_model.dart';
import 'package:promotion_dashboard/data/resource/remote/home/categories_data.dart';
import 'package:promotion_dashboard/data/resource/remote/home/products_data.dart';

abstract class UpdateProductController extends GetxController {
  // Text controllers
  List<TextEditingController> nameController = [];
  List<TextEditingController> descriptionController = [];
  late TextEditingController purchasePriceController;
  late TextEditingController salePriceController;
  late TextEditingController minController;
  late TextEditingController maxController;

  // Dropdown values
  String typeValue = 'live';
  String visibleValue = 'Yes';
  String availableValue = 'Yes';
  String numberlyValue = 'Yes';
  String categoryValue = '';
  String sourceValue = 'internal';

  // Categories data
  List<CategoryModel>? categories;
  List<String> categoriesName = [];

  // Images list
  List<File> selectedImages = [];

  // Methods (abstract)
  void updateTypeValue(String value);
  void updateVisibleValue(String value);
  void updateNumberlyValue(String value);
  void updateSourceValue(String value);
  void updateCategoryValue(String value);
  void updateAvailableValue(String value);
  Future<void> pickImages();
  void removeImage(File image);
  Future<void> getCategoriesData();
  void showProduct();
  void initialProduct(ProductModel product);
  Future<void> updateProuct();
  void cancel();
}

class UpdateProductControllerImp extends UpdateProductController {
  CategoriesData categoriesData = CategoriesData();
  ProductModel? productModel;

  ProductsData productData = ProductsData();
  bool loading = false;
  int productId = 0;
  int categoryId = 0;

  @override
  void onInit() {
    super.onInit();

    productId = int.parse(Get.parameters['product_id'] ?? '0');
    showProduct();

    for (var i = 0; i < myLanguages.length; i++) {
      nameController.add(TextEditingController());
      descriptionController.add(TextEditingController());
    }
    purchasePriceController = TextEditingController();
    salePriceController = TextEditingController();
    minController = TextEditingController();
    maxController = TextEditingController();
  }

  @override
  Future<void> getCategoriesData() async {
    loading = true;
    update();

    var response = await categoriesData.get();
    if (response.isSuccess) {
      categories = List.generate(
        response.data.length,
        (index) => CategoryModel.fromJson(response.data[index]),
      );

      if (categories != null) {
        categoriesName = categories!
            .map((category) => category.name.en!.isNotEmpty
                ? category.name.en!
                : category.name.ar!)
            .toSet()
            .toList();
      }

      if (!categoriesName.contains(categoryValue)) {
        categoriesName.add(categoryValue);
      }
    }

    loading = false;
    update();
  }

  @override
  Future<void> showProduct() async {
    await getCategoriesData();

    loading = true;
    update();
    var response = await productData.show(productId);
    if (response.isSuccess) {
      productModel = ProductModel.fromJson(response.data);
      initialProduct(productModel!);
    }
    loading = false;

    update();
  }

  @override
  initialProduct(ProductModel product) {
    productModel = product;
    categoryId = product.productCategoryId;
    getValues(nameController, product.name.toJson());
    getValues(descriptionController, product.description.toJson());
    purchasePriceController.text = product.purchasePrice.toString();
    salePriceController.text = product.salePrice.toString();
    minController.text = product.min.toString();
    maxController.text = product.max.toString();
    typeValue = product.type;
    visibleValue = product.visible == true ? 'Yes' : 'No';
    availableValue = product.available == true ? 'Yes' : 'No';
    numberlyValue = product.numberly == true ? 'Yes' : 'No';
    sourceValue = product.source.toLowerCase();
    updateVisibleValue(visibleValue);
    for (int i = 0; i < categories!.length; i++) {
      if (categoryId == categories![i].id) {
        categoryValue = categories![i].name.en!;
        break;
      }
    }
    update();
  }

  @override
  void updateTypeValue(String value) {
    typeValue = value;
  }

  @override
  void updateVisibleValue(String value) {
    visibleValue = value;
    update();
  }

  @override
  void updateNumberlyValue(String value) {
    numberlyValue = value;
  }

  @override
  void updateSourceValue(String value) {
    sourceValue = value;
    update();
  }

  @override
  void updateCategoryValue(String value) {
    categoryValue = value;
    for (final category in categories ?? []) {
      if (category.name.en == value || category.name.ar == value) {
        categoryId = category.id;
        break;
      }
    }

    log('Selected Category ID: $productId');
    update();
  }

  @override
  void updateAvailableValue(String value) {
    availableValue = value;
  }

  @override
  Future<void> pickImages() async {
    try {
      ImagePicker picker = ImagePicker();

      final List<XFile> images = await picker.pickMultiImage();
      if (images.isNotEmpty) {
        selectedImages.addAll(images.map((image) => File(image.path)).toList());
      } else {
        customSnackBar(
          "إلغاء",
          "لم يتم اختيار أي صورة.",
          snackType: SnackBarType.warning,
        );
      }
    } catch (e) {
      customSnackBar("خطأ", "حدث خطأ أثناء اختيار الصور: $e",
          snackType: SnackBarType.error);
    } finally {
      update();
    }
  }

  @override
  void removeImage(File image) {
    selectedImages.remove(image);
    update();
  }

  @override
  Future<void> updateProuct() async {
    loading = true;
    update();
    var response = await productData.update(
        id: productId,
        names: setValues(nameController),
        descriptions: setValues(descriptionController),
        visible: visibleValue == 'Yes' ? true : false,
        productCategoryId: categoryId,
        purchasePrice: num.tryParse(purchasePriceController.text) ?? 0,
        salePrice: num.tryParse(salePriceController.text) ?? 0,
        source: sourceValue,
        available: availableValue == 'Yes' ? true : false,
        numberly: numberlyValue == 'Yes' ? true : false,
        min: num.tryParse(minController.text),
        max: num.tryParse(maxController.text));
    if (response.isSuccess) {
      Get.back();
      customSnackBar(response.message ?? '', '');
    }
    loading = false;
    update();
  }

  @override
  void cancel() {}

  @override
  void onClose() {
    super.onClose();
    nameController.clear();
    descriptionController.clear();
    purchasePriceController.dispose();
    salePriceController.dispose();
    minController.dispose();
    maxController.dispose();
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
        (categoryData[myLanguages.entries.toList()[i].key] ?? '').toString();
  }

  return data;
}
