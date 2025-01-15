import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/home/categories/categories_management_controller.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/core/constants/routes.dart';
import 'package:promotion_dashboard/core/widgets/handling_data_view.dart';
import 'package:promotion_dashboard/view/widgets/categories/sf_data_grid_categories.dart'; // Ensure this import is correct and the file exists
import 'package:promotion_dashboard/view/widgets/general/custom_button.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_text_field.dart';

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
        backgroundColor: AppColors.screenColor,
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: MyText.appStyle.fs24.wBold.reColorText
                      .responsiveStyle(context),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: CustomTextField(
                        label: 'Search',
                        controller: controller.searchController,
                        onChanged: controller.filterCategories,
                        inputType: TextInputType.text,
                      ),
                    ),
                    const SizedBox(width: 10),
                    CustomButton(
                      title: 'Add category',
                      height: 45,
                      onPressed: () async {
                        await Get.toNamed(AppRoutes.createCategory);
                        controller.getPCategoriesData();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Expanded(
                  child: SFDataGridCategories(),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
