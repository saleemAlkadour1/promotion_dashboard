// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/products/products_management_controller.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/view/screens/product.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_button.dart';
import 'package:promotion_dashboard/view/widgets/product/sf_data_grid_products.dart';

class ProductsManagement extends StatelessWidget {
  const ProductsManagement({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProductsManagementControllerImp());
    return GetBuilder<ProductsManagementControllerImp>(builder: (controller) {
      return Scaffold(
        body: Row(
          children: [
            const SizedBox(
              width: 32,
            ),
            Expanded(
              flex: 6,
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 32,
                        ),
                        Text(
                          'Products',
                          style: MyText.appStyle.fs24.wBold.reColorText
                              .responsiveStyle(context),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                  title: 'Add product',
                                  height: 45,
                                  onPressed: () {
                                    Get.to(Product());
                                  }),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        controller.loading == true
                            ? Expanded(
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: AppColors.color_4EB7F2,
                                )),
                              )
                            : SizedBox(
                                height: 500,
                                child: SFDataGridProducts(
                                  products: controller.products,
                                ),
                              ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 32,
            ),
          ],
        ),
      );
    });
  }
}
