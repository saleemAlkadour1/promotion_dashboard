// ignore_for_file: use_super_parameters, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/categories/update_category_controller.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/data/model/category_model.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_button.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_drop_down.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_image_picker.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_text_field.dart';

class UpdateCategory extends StatelessWidget {
  const UpdateCategory({super.key, required this.categoryModel});
  final CategoryModel categoryModel;
  @override
  Widget build(BuildContext context) {
    UpdateCategoryControllerImp initialController =
        Get.put(UpdateCategoryControllerImp());
    initialController.initialCategory(categoryModel);
    return GetBuilder<UpdateCategoryControllerImp>(builder: (controller) {
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
                ),
                const SizedBox(height: 16.0),
                // Description
                CustomTextField(
                  controller: controller.descriptionController,
                  label: 'Description',
                ),
                const SizedBox(height: 16.0),

                // Visible Dropdown
                CustomDropdown(
                  label: 'Visible',
                  value: controller.visibleValue,
                  items: const ['Yes', 'No'],
                  onChanged: controller.updateVisibleValue,
                ),
                const SizedBox(height: 16.0),
                // Pick and Display Images
                CustomImagePicker(
                  images: controller.selectedImages,
                  onAddImage: controller.pickImages,
                  onRemoveImage: controller.removeImage,
                ),
                const SizedBox(height: 16.0),
                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomButton(
                        height: 40,
                        title:
                            controller.loading == true ? 'Loading...' : 'Save',
                        onPressed: () async {
                          Get.back();
                          await controller.updateCategory(categoryModel.id);
                        }),
                    SizedBox(
                      width: 20,
                    ),
                    CustomButton(
                        title: 'Cancel',
                        height: 40,
                        backgroundColor: AppColors.white,
                        textColor: Colors.blue,
                        onPressed: () {
                          Get.back();
                        }),
                  ],
                ),
              ],
            ),
          ));
    });
  }
}
