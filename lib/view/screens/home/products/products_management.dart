import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/home/products/products_management_controller.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/core/constants/routes.dart';
import 'package:promotion_dashboard/view/screens/home/products/create_product.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_button.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_drop_down.dart';
import 'package:promotion_dashboard/view/widgets/products/sf_data_grid_products.dart';

class ProductsManagement extends StatelessWidget {
  const ProductsManagement({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProductsManagementControllerImp());
    return GetBuilder<ProductsManagementControllerImp>(builder: (controller) {
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
                  style: MyText.appStyle.fs24.wBold
                      .reCustomColor(AppColors.black)
                      .responsiveStyle(context),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: CustomDropdown(
                        label: 'Type',
                        value: controller.typeValue,
                        items: [
                          'All',
                          Product.live.type,
                          Product.store.type,
                          Product.manual.type,
                        ],
                        onChanged: controller.updateTypeValue,
                      ),
                    ),
                    const SizedBox(width: 10),
                    CustomButton(
                        title: 'Add product',
                        height: 45,
                        onPressed: () async {
                          await Get.toNamed(AppRoutes.createProduct);
                          await controller.getProductsData(
                              pageIndex:
                                  controller.paganationDataModel.currentPage);
                        }),
                  ],
                ),
                const SizedBox(height: 16),
                const Expanded(
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
