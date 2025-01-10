import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/core/functions/snackbar.dart';
import 'package:promotion_dashboard/data/model/servers/five_sim_product_model.dart';
import 'package:promotion_dashboard/data/resource/remote/auth/servers/five_sim_data.dart';

abstract class FiveSimController extends GetxController {
  late TextEditingController searchProduct;
  Future<void> getProducts();
}

class FiveSimControllerImp extends FiveSimController {
  List<FiveSimProductModel>? products;
  List<FiveSimProductModel>? filteredProducts;

  List<Country> countries = [
    Country("Afghanistan", [
      Operator("Virtual21", Price(0.5844, "USD"), 60),
      Operator("Virtual21", Price(0.5844, "USD"), 60),
    ]),
  ];

  FiveSimProductModel? selectedProduct;
  Country? selectedCountry;
  Operator? selectedOperator;

  FiveSimData fiveSimData = FiveSimData();
  bool loading = false;
  @override
  Future<void> getProducts() async {
    loading = true;
    update();
    var response = await fiveSimData.get();
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
  void onInit() {
    super.onInit();
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

  void selectProduct(FiveSimProductModel product) {
    selectedProduct = product;
    update();
  }

  void selectCountry(Country country) {
    selectedCountry = country;
    update();
  }

  void selectOperator(Operator operator) {
    selectedOperator = operator;
    update();
  }

  @override
  void onClose() {
    searchProduct.dispose();
    super.onClose();
  }
}

class Country {
  final String name;
  final List<Operator> operators;

  Country(this.name, this.operators);
}

class Operator {
  final String name;
  final Price price;
  final double cost;

  Operator(this.name, this.price, this.cost);
}

class Price {
  final double amount;
  final String currency;

  Price(this.amount, this.currency);
}
