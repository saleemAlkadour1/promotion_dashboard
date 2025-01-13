// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/home/products/products_management_controller.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/core/constants/routes.dart';
import 'package:promotion_dashboard/core/widgets/handling_data_view.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_button.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_text_field.dart';
import 'package:promotion_dashboard/view/widgets/products/sf_data_grid_products.dart';

class ProductsManagement extends StatelessWidget {
  const ProductsManagement({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProductsManagementControllerImp());
    return GetBuilder<ProductsManagementControllerImp>(builder: (controller) {
      var res = HandlingDataView(
        loading: controller.loading,
        dataIsEmpty: controller.products == null,
      );
      if (res.isValid) {
        return res.response!;
      }
      return Scaffold(
        backgroundColor: AppColors.screenColor,
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Products',
                  style: MyText.appStyle.fs24.wBold.reColorText
                      .responsiveStyle(context),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: CustomTextField(
                          controller: TextEditingController(), label: 'Search'),
                    ),
                    const SizedBox(width: 10),
                    CustomButton(
                        title: 'Add product',
                        height: 45,
                        onPressed: () async {
                          await Get.toNamed(AppRoutes.createProduct);
                          controller.getProductsData();
                        }),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SFDataGridProducts(),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
