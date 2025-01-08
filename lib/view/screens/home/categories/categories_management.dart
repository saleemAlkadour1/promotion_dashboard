import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/home/categories/categories_management_controller.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/core/widgets/handling_data_view.dart';
import 'package:promotion_dashboard/view/widgets/categories/sf_data_grid_categories.dart'; // Ensure this import is correct and the file exists
import 'package:promotion_dashboard/view/widgets/general/custom_button.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_drop_down.dart';

class CategoriesManagement extends StatelessWidget {
  const CategoriesManagement({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CategoriesManagementControllerImp());
    return GetBuilder<CategoriesManagementControllerImp>(builder: (controller) {
      var res = HandlingDataView(
        loading: controller.loading,
        dataIsEmpty: controller.categories == null,
      );
      if (res.isValid) {
        return res.response!;
      }
      return Scaffold(
        body: Row(
          children: [
            const SizedBox(width: 32),
            Expanded(
              flex: 6,
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: true,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 32),
                          Text(
                            'Categories',
                            style: MyText.appStyle.fs24.wBold.reColorText
                                .responsiveStyle(context),
                          ),
                          const SizedBox(height: 32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: CustomDropdown(
                                  //TODO: To change later
                                  label: 'Visible',
                                  value: 'Yes',
                                  items: const ['Yes', 'No'],
                                  onChanged: (value) {},
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CustomButton(
                                title: 'Add category',
                                height: 45,
                                onPressed: controller.onPressedAddProduct,
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          const SizedBox(
                            height: 500,
                            child: SFDataGridCategories(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 32),
          ],
        ),
      );
    });
  }
}
