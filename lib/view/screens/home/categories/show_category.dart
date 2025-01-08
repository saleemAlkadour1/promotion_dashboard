// ignore_for_file: use_super_parameters, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/home/categories/show_category_controller.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/core/widgets/handling_data_view.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_text_field.dart';

class ShowCategory extends StatelessWidget {
  const ShowCategory({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(ShowCategoryControllerImp());
    return GetBuilder<ShowCategoryControllerImp>(
      builder: (controller) {
        var res = HandlingDataView(
          loading: true,
          dataIsEmpty: controller.categoryModel == null,
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
                  'Update category',
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
            body: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  CustomTextField(
                    controller: controller.nameController,
                    label: 'Name',
                    enabled: false,
                  ),
                  const SizedBox(height: 16.0),
                  // Description
                  CustomTextField(
                    controller: controller.descriptionController,
                    label: 'Description',
                    enabled: false,
                  ),
                  const SizedBox(height: 16.0),

                  // Visible
                  CustomTextField(
                    controller: controller.visibleController,
                    label: 'Visible',
                    enabled: false,
                  ),

                  const SizedBox(height: 16.0),
                ],
              ),
            ));
      },
    );
  }
}
