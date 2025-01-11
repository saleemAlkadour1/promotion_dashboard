import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/home/products/products_management_controller.dart';
import 'package:promotion_dashboard/core/constants/routes.dart';
import 'package:promotion_dashboard/core/functions/snackbar.dart';
import 'package:promotion_dashboard/data/model/servers/five_sim/country_model.dart';
import 'package:promotion_dashboard/data/model/servers/five_sim/five_sim_product_model.dart';
import 'package:promotion_dashboard/data/model/servers/five_sim/operator_model.dart';
import 'package:promotion_dashboard/data/resource/remote/home/product_data.dart';
import 'package:promotion_dashboard/data/resource/remote/servers/five_sim_data.dart';

abstract class FiveSimController extends GetxController {
  late TextEditingController searchProduct;
  Future<void> getProducts();
  Future<void> getCountriesAndOperators(String product);
  selectProduct(FiveSimProductModel product);
  createProuct();
  void receiveParameters();
}

class FiveSimControllerImp extends FiveSimController {
  // المتغيرات لتخزين البيانات المستقبلة
  String? name;
  String? description;
  bool? visible;
  int? productCategoryId;
  String? type;
  double? purchasePrice;
  double? salePrice;
  String? numberly;
  String? source;
  List<File>? images;
  int? min;
  int? max;
  bool? available;
  String? serverName;
  @override
  void receiveParameters() {
    name = jsonDecode(Get.parameters['name']!)['en'];
    description = jsonDecode(Get.parameters['description']!)['en'];
    visible = Get.parameters['visible'] == 'true';
    productCategoryId =
        int.tryParse(Get.parameters['product_category_id'] ?? '');
    type = Get.parameters['type'];
    purchasePrice = double.tryParse(Get.parameters['purchase_price'] ?? '');
    salePrice = double.tryParse(Get.parameters['sale_price'] ?? '');
    numberly = Get.parameters['numberly'];
    source = Get.parameters['source'];
    images = (Get.parameters['images']?.split('||unique_separator||'))!
        .map((path) => File(path))
        .toList();
    min = int.tryParse(Get.parameters['min']!);
    max = int.tryParse(Get.parameters['max']!);
    available = Get.parameters['available'] == 'true';
    serverName = Get.parameters['server_name'];
  }

  List<FiveSimProductModel>? products;
  List<FiveSimProductModel>? filteredProducts;
  List<CountryModel>? countries;

  FiveSimProductModel? selectedProduct;
  CountryModel? selectedCountry;
  OperatorModel? selectedOperator;

  FiveSimData fiveSimData = FiveSimData();
  ProductData productData = ProductData();
  bool loading = false;
  @override
  Future<void> getProducts() async {
    loading = true;
    update();
    var response = await fiveSimData.getProducts();
    if (response.isSuccess) {
      products = List.generate(response.data.length,
          (index) => FiveSimProductModel.fromJson(response.data[index]));
      filteredProducts = products;

      customSnackBar('', response.message ?? 'Success get data',
          snackType: SnackBarType.correct);
    }
    loading = false;
    update();
  }

  @override
  Future<void> getCountriesAndOperators(String product) async {
    countries = null;

    Get.toNamed(AppRoutes.selectCountryAndOperator);

    loading = true;
    update();
    var response = await fiveSimData.getCountriesAndOperators(product);
    if (response.isSuccess) {
      countries = List.generate(response.data.length,
          (index) => CountryModel.fromJson(response.data[index]));
      customSnackBar('', response.message ?? 'Success');
    }
    loading = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    receiveParameters();
    getProducts();
    searchProduct = TextEditingController();
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      filteredProducts = products!;
    } else {
      filteredProducts = products!
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    update();
  }

  @override
  void selectProduct(FiveSimProductModel product) async {
    selectedProduct = product;
    await getCountriesAndOperators(product.name);
    update();
  }

  void selectCountry(CountryModel country) {
    selectedCountry = country;
    update();
  }

  void selectOperator(OperatorModel operator) {
    selectedOperator = operator;
    update();
  }

  @override
  Future<void> createProuct() async {
    if (selectedProduct != null &&
        selectedCountry != null &&
        selectedOperator != null) {
      loading = true;
      update();
      var response = await productData.create(
        name: name!,
        description: description!,
        visible: true,
        productCategoryId: productCategoryId!,
        type: type!,
        purchasePrice: purchasePrice!,
        salePrice: salePrice!,
        numberly: true,
        source: source!,
        images: images!,
        available: true,
        serverName: serverName!,
        productName: selectedProduct!.name,
        countryName: selectedCountry!.countryName,
        operatorName: selectedOperator!.name,
      );
      if (response.isSuccess) {
        Get.find<ProductsManagementControllerImp>().getProductsData();
        await Get.offAllNamed(AppRoutes.home);
        customSnackBar('Success', response.message ?? 'Success',
            snackType: SnackBarType.correct);
      }
      loading = false;
      update();
    } else {
      customSnackBar('Error', 'Please select a product, country, and operator',
          snackType: SnackBarType.error);
    }
  }

  @override
  void onClose() {
    searchProduct.dispose();
    super.onClose();
  }
}
