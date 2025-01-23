import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:promotion_dashboard/core/functions/snackbar.dart';
import 'package:promotion_dashboard/core/localization/changelocale.dart';
import 'package:promotion_dashboard/data/model/general/paganiation_data_model.dart';
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
  late String categoryValue;
  String sourceValue = 'internal';

  // Categories data
  List<CategoryModel> categories = [];
  List<String> categoriesName = [];

  // Images list
  List<String> oldImages = [];
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
  void removeOldImage(String pathImage);
  Future<void> getCategoriesData();
  void showProduct();
  void initialProduct(ProductModel product);
  Future<void> updateProuct();
  void cancel();
}

class UpdateProductControllerImp extends UpdateProductController {
  CategoriesData categoriesData = CategoriesData();
  ProductModel? productModel;
  bool isImageFinds = true;

  ProductsData productData = ProductsData();
  bool loading = false;
  int productId = 0;
  int categoryId = 0;

  @override
  void onInit() {
    super.onInit();
    categoryValue = '';
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
    var responsePaganation = await categoriesData.get(indexPage: 1);
    PaganationDataModel paganationDataModelCategories =
        PaganationDataModel.fromJson(responsePaganation.body['meta']);
    for (int i = 1; i <= paganationDataModelCategories.lastPage; i++) {
      var response = await categoriesData.get(indexPage: i);
      if (response.isSuccess) {
        categories.addAll(List.generate(
          response.data.length,
          (index) => CategoryModel.fromJson(response.data[index]),
        ));

        // Populate categories names
        if (categories.isNotEmpty) {
          categoriesName.addAll(
              categories.map((category) => category.name.en!).toSet().toList());
        }
        // Ensure the default categoryValue exists in the list
        if (!categoriesName.contains(categoryValue)) {
          categoriesName.add(categoryValue);
        }
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
    for (int i = 0; i < product.images.length; i++) {
      oldImages.add(product.images[i].path);
    }

    // تحديد قيمة الفئة
    for (int i = 0; i < categories.length; i++) {
      if (categoryId == categories[i].id) {
        categoryValue = categories[i].name.en!;
        break;
      }
    }

    // تحقق من أن القيمة الافتراضية موجودة في القائمة
    if (!categoriesName.contains(categoryValue)) {
      if (categoriesName.isNotEmpty) {
        categoryValue = categoriesName.first; // تعيين أول قيمة كافتراضية
      } else {
        categoryValue = ''; // تعيين قيمة فارغة إذا لم تكن هناك خيارات
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
    for (final category in categories) {
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
    isImageFinds = false;
    update();

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
    isImageFinds = false;
    selectedImages.remove(image);
    update();
  }

  @override
  void removeOldImage(String pathImage) {
    isImageFinds = false;
    oldImages.remove(pathImage);
    update();
  }

  @override
  Future<void> updateProuct() async {
    loading = true;
    update();
    // List<File> newImages = [];
    // newImages.addAll(selectedImages);
    // if (oldImages.isNotEmpty) {
    //   var convertedImages = await convertUrlsToFiles(oldImages);
    //   if (convertedImages.isNotEmpty) {
    //     newImages.addAll(convertedImages);
    //   } else {
    //     log("No images were converted from oldImages.");
    //   }
    // }

    // إذا كانت القائمة فارغة بعد إضافة الصور القديمة
    // if (newImages.isEmpty) {
    //   customSnackBar('Error', 'You must choose images.',
    //       snackType: SnackBarType.error);
    //   return;
    // }

    // تحديد الصور التي سترسلها بناءً على قيمة `isImageFinds`
    // List<File>? imagesToSend = isImageFinds ? null : selectedImages;

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
      max: num.tryParse(maxController.text),
      images: selectedImages,
    );

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

Future<List<File>> convertUrlsToFiles(List<String> imageUrls) async {
  List<File> files = [];
  for (String url in imageUrls) {
    try {
      // استخدم Dio لتحميل البيانات كـ Uint8List
      var response = await Dio().get<List<int>>(
        url,
        options: Options(responseType: ResponseType.bytes),
      );

      // قم بإنشاء ملف مؤقت لكل صورة
      String tempPath = (await getTemporaryDirectory()).path;
      File tempFile =
          File('$tempPath/${DateTime.now().millisecondsSinceEpoch}.jpg');

      // كتابة البايتات إلى الملف
      await tempFile.writeAsBytes(response.data!);

      files.add(tempFile);
    } catch (e) {
      log("خطأ أثناء تحميل الصورة من الرابط $url: $e");
    }
  }

  if (files.isEmpty) {
    log("No images were converted from oldImages.");
  }

  return files;
}
