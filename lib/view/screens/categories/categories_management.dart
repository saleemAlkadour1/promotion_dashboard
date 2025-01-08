// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/categories/categories_management_controller.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/view/screens/categories/category.dart';
import 'package:promotion_dashboard/view/widgets/category/sf_data_grid_categories.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_button.dart';

class CategoriesManagement extends StatelessWidget {
  const CategoriesManagement({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CategoriesManagementControllerImp());
    return GetBuilder<CategoriesManagementControllerImp>(builder: (controller) {
      return Row(
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
                        'Categories',
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
                                title: 'Add category',
                                height: 45,
                                onPressed: () {
                                  Get.to(Category());
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
                              child: SFDataGridCategories(),
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
      );
    });
  }
}
