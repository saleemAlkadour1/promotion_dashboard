import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:promotion_dashboard/core/classes/shared_preferences.dart';
import 'package:promotion_dashboard/core/constants/routes.dart';
import 'package:promotion_dashboard/core/constants/storage_keys.dart';
import 'package:promotion_dashboard/core/functions/snackbar.dart';
import 'package:promotion_dashboard/core/localization/changelocale.dart';
import 'package:promotion_dashboard/data/model/home/category_model.dart';
import 'package:promotion_dashboard/data/resource/remote/home/categories_data.dart';
import 'package:promotion_dashboard/data/resource/remote/home/product_data.dart';
import 'package:promotion_dashboard/view/screens/home/products/create_product.dart';

abstract class CreateProductController extends GetxController {
  // Text controllers
  List<TextEditingController> nameController = [];
  List<TextEditingController> descriptionController = [];
  late TextEditingController purchasePriceController;
  late TextEditingController salePriceController;
  late TextEditingController minController;
  late TextEditingController maxController;

  // Dropdown values
  String visibleValue = 'Yes';
  String availableValue = 'Yes';
  String typeValue = 'live';
  String numberlyValue = 'Yes';
  String categoryValue = '';
  String sourceValue = 'Internal';
  String serverNameValue = 'five_sim';

  // Categories data
  List<CategoryModel>? categories;
  List<String> categoriesName = [];

  // Images list
  List<File> selectedImages = [];

  // Methods (abstract)
  void updateVisibleValue(String value);
  void updateTypeValue(String value);
  void updateNumberlyValue(String value);
  void updateSourceValue(String value);
  void updateCategoryValue(String value);
  void updateAvailableValue(String value);
  void updateServerNameValue(String value);
  Future<void> pickImages();
  void removeImage(File image);
  getPCategoriesData();
  Future<void> createProuct();
  void link();
  void cancel();
}

class CreateProductControllerImp extends CreateProductController {
  CategoriesData categoriesData = CategoriesData();
  ProductData productData = ProductData();
  bool loading = false;
  int categoryId = 0;

  @override
  getPCategoriesData() async {
    loading = true;
    update();

    var response = await categoriesData.get();
    if (response.isSuccess) {
      categories = List.generate(
        response.data.length,
        (index) => CategoryModel.fromJson(response.data[index]),
      );

      // Populate categories names
      if (categories != null) {
        categoriesName =
            categories!.map((category) => category.name.en!).toSet().toList();
      }

      // Ensure the default categoryValue exists in the list
      if (!categoriesName.contains(categoryValue)) {
        categoriesName.add(categoryValue);
      }
    }

    loading = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();

    getPCategoriesData();
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
      if (category.name.en == value) {
        categoryId = category.id;
        break;
      }
    }

    log('Selected Category ID: $categoryId');
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
  void updateServerNameValue(String value) {
    serverNameValue = value;
  }

  @override
  void link() {
    Get.toNamed(AppRoutes.selectProduct);
    update();
  }

  @override
  Future<void> createProuct() async {
    if (typeValue == Product.live.type && serverNameValue == 'five_sim') {
      Map fiveSimData = Shared.getMapValue('five_sim_data');
      Map names = setValues(nameController);
      Map descriptions = setValues(descriptionController);
      loading = true;
      update();
      var response = await productData.createLive(
        name: names['en'],
        description: descriptions['en'],
        visible: true,
        productCategoryId: categoryId,
        type: typeValue,
        purchasePrice: num.tryParse(purchasePriceController.text) ?? 0,
        salePrice: num.tryParse(salePriceController.text) ?? 0,
        numberly: true,
        source: 'internal',
        images: selectedImages,
        available: true,
        serverName: 'five_sim',
        productName: fiveSimData['product_name'],
        countryName: fiveSimData['country_name'],
        operatorName: fiveSimData['operator_name'],
      );
      if (response.isSuccess) {
        Get.back();
        customSnackBar('', response.message ?? '',
            snackType: SnackBarType.correct);
      }
      loading = false;
      update();
    } else if (typeValue == Product.store.type) {
      Map storeProducts = Shared.getMapValue(StorageKeys.storeProducts);
      int productId = int.tryParse(storeProducts['product_id']) ?? 0;
      List values = storeProducts['values'];
      loading = true;
      update();
      var response = await productData.createStore(
        visible: true,
        productId: productId,
        values: values,
      );
      if (response.isSuccess) {
        Get.back();
        customSnackBar('', response.message ?? '');
      }
      loading = false;
      update();
    }
  }

  @override
  void cancel() {}

  @override
  void onClose() {
    super.onClose();
    // nameController.clear();
    // descriptionController.clear();
    // purchasePriceController.dispose();
    // salePriceController.dispose();
    // minController.dispose();
    // maxController.dispose();
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
