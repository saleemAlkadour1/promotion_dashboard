import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/home/products/create_product_controller.dart';
import 'package:promotion_dashboard/core/classes/shared_preferences.dart';
import 'package:promotion_dashboard/core/constants/routes.dart';
import 'package:promotion_dashboard/core/functions/snackbar.dart';
import 'package:promotion_dashboard/data/model/home/products/products_type/live/servers/five_sim/country_model.dart';
import 'package:promotion_dashboard/data/model/home/products/products_type/live/servers/five_sim/five_sim_product_model.dart';
import 'package:promotion_dashboard/data/model/home/products/products_type/live/servers/five_sim/operator_model.dart';
import 'package:promotion_dashboard/data/resource/remote/servers/five_sim_data.dart';

abstract class FiveSimController extends GetxController {
  late TextEditingController searchProduct;
  Future<void> getProducts();
  Future<void> getCountriesAndOperators(String product);
  selectProduct(FiveSimProductModel product);
  void backToCreateProduct();

  // void receiveParameters();
}

class FiveSimControllerImp extends FiveSimController {
  List<FiveSimProductModel>? products;
  List<FiveSimProductModel>? filteredProducts;
  List<CountryModel>? countries;

  FiveSimProductModel? selectedProduct;
  CountryModel? selectedCountry;
  OperatorModel? selectedOperator;

  FiveSimData fiveSimData = FiveSimData();
  bool loading = false;
  @override
  Future<void> getProducts() async {
    loading = true;
    update();
    var response = await fiveSimData.getProducts();
    if (response.isSuccess) {
      products = List.generate(response.data.length, (index) => FiveSimProductModel.fromJson(response.data[index]));
      filteredProducts = products;

      customSnackBar('', response.message ?? 'Success get data', snackType: SnackBarType.correct);
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
      countries = List.generate(response.data.length, (index) => CountryModel.fromJson(response.data[index]));
      customSnackBar('', response.message ?? 'Success');
    }
    loading = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getProducts();
    searchProduct = TextEditingController();
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      filteredProducts = products!;
    } else {
      filteredProducts = products!.where((product) => product.name.toLowerCase().contains(query.toLowerCase())).toList();
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
  void backToCreateProduct() {
    if (selectedProduct != null && selectedCountry != null && selectedOperator != null) {
      Get.find<CreateProductControllerImp>().salePriceController.text = selectedOperator!.price.amount.toString();
      Shared.setValue('server_data', {
        'product': selectedProduct!.name,
        'country': selectedCountry!.countryName,
        'operator': selectedOperator!.name,
      });
      Get.back();
      Get.back();
    } else {
      customSnackBar('خطأ', 'يجب أن تكمل الاختيار', snackType: SnackBarType.error);
    }
  }

  @override
  void onClose() {
    searchProduct.dispose();
    super.onClose();
  }
}
