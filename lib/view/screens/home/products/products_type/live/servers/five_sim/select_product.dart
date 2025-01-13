// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/home/products/products_type/live/servers/five_sim_controller.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/core/widgets/handling_data_view.dart';
import 'package:promotion_dashboard/data/model/home/products/products_type/live/servers/five_sim/five_sim_product_model.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_text_field.dart';

class SelectProduct extends StatelessWidget {
  const SelectProduct({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FiveSimControllerImp());

    return GetBuilder<FiveSimControllerImp>(builder: (controller) {
      var res = HandlingDataView(
        loading: controller.loading,
        dataIsEmpty: controller.filteredProducts == null,
      );
      if (res.isValid) {
        return res.response!;
      }
      return Scaffold(
        backgroundColor: AppColors.screenColor,
        appBar: AppBar(
            backgroundColor: AppColors.color_F7F9FA,
            elevation: 0,
            scrolledUnderElevation: 0,
            shadowColor: AppColors.transparent,
            title: Text(
              'Select product',
              style: MyText.appStyle.fs16.wBold.reColorText.style,
            ),
            automaticallyImplyLeading: false,
            leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.black,
                ),
              ),
            )),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 16),
                  child: CustomTextField(
                    controller: controller.searchProduct,
                    label: 'Search Product',
                    onChanged: (value) => controller.searchProducts(value),
                  )),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: controller.filteredProducts!
                            .asMap()
                            .entries
                            .map((entry) {
                          FiveSimProductModel product = entry.value;
                          return ProductCard(
                            onTap: () {
                              controller.selectProduct(product);
                            },
                            product: product,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
  });

  final FiveSimProductModel product;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FiveSimControllerImp>(builder: (controller) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          width: MediaQuery.of(context).size.width > 600
              ? 200
              : MediaQuery.of(context).size.width * 0.4,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: controller.selectedProduct == product
                ? Colors.blue.shade100
                : Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                product.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text("Category: ${product.category}"),
              Text("Quantity: ${product.quantity}"),
              Text("Price: ${product.price}"),
            ],
          ),
        ),
      );
    });
  }
}
