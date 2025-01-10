// ignore_for_file: use_super_parameters, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/home/products/create_product_controller.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/core/localization/changelocale.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_button.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_drop_down.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_image_picker.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_text_field.dart';

class CraeteProduct extends StatelessWidget {
  const CraeteProduct({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CreateProductControllerImp());
    return GetBuilder<CreateProductControllerImp>(builder: (controller) {
      return Scaffold(
          backgroundColor: AppColors.screenColor,
          appBar: AppBar(
              backgroundColor: AppColors.color_F7F9FA,
              elevation: 0,
              scrolledUnderElevation: 0,
              shadowColor: AppColors.transparent,
              title: Text(
                'Add product',
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
                //Category
                CustomDropdown(
                  label: 'Category',
                  items: controller.categoriesName,
                  onChanged: controller.updateCategoryValue,
                ),
                const SizedBox(height: 16.0),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name',
                      style: MyText.appStyle.fs16.wBold.reColorText.style,
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    ...List.generate(
                      myLanguages.entries.toList().length,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: CustomTextField(
                            controller: controller.nameController[index],
                            label:
                                '${(myLanguages.entries.toList()[index].value['name']).toString().capitalizeFirst}',
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Description',
                      style: MyText.appStyle.fs16.wBold.reColorText.style,
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    ...List.generate(
                      myLanguages.entries.toList().length,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: CustomTextField(
                            controller: controller.descriptionController[index],
                            label:
                                '${(myLanguages.entries.toList()[index].value['name']).toString().capitalizeFirst}',
                          ),
                        );
                      },
                    )
                  ],
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
                CustomDropdown(
                  label: 'Avilable',
                  value: controller.availableValue,
                  items: const ['Yes', 'No'],
                  onChanged: controller.updateAvailableValue,
                ),
                const SizedBox(height: 16.0),

                // Purchase Price
                CustomTextField(
                  controller: controller.purchasePriceController,
                  label: 'Purchase Price',
                  inputType: TextInputType.number,
                ),
                const SizedBox(height: 16.0),

                // Sale Price
                CustomTextField(
                  controller: controller.salePriceController,
                  label: 'Sale Price',
                  inputType: TextInputType.number,
                ),
                const SizedBox(height: 16.0),
                // Min
                CustomTextField(
                  controller: controller.minController,
                  label: 'Min',
                  inputType: TextInputType.number,
                ),
                const SizedBox(height: 16.0),

                // Max
                CustomTextField(
                  controller: controller.maxController,
                  label: 'Max',
                  inputType: TextInputType.number,
                ),
                const SizedBox(height: 16.0),

                // Source Dropdown
                CustomDropdown(
                  label: 'Source',
                  value: controller.sourceValue,
                  items: const ['Internal', 'External'],
                  onChanged: controller.updateSourceValue,
                ),
                const SizedBox(height: 16.0),

                // Pick and Display Images
                CustomImagePicker(
                  images: controller.selectedImages,
                  onAddImage: controller.pickImages,
                  onRemoveImage: controller.removeImage,
                ),
                const SizedBox(height: 16.0),

                // Type Dropdown
                CustomDropdown(
                  label: 'Type',
                  value: controller.typeValue,
                  items: const ['Live', 'Store'],
                  onChanged: controller.updateTypeValue,
                ),
                const SizedBox(height: 16.0),
                if (controller.typeValue == 'Live')
                  CustomDropdown(
                    label: 'Server name',
                    value: controller.serverNameValue,
                    items: const ['five_sim'],
                    onChanged: controller.updateServerNameValue,
                  ),
                // if (controller.typeValue == 'Store')
                //   const Text(
                //     'Store Product Selected',
                //     style: TextStyle(fontSize: 16.0, color: Colors.blue),
                //   ),
                const SizedBox(height: 16.0),

                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomButton(
                      height: 40,
                      title: 'Next',
                      onPressed: controller.next,
                    ),
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

final Map<String, Widget> typeSpecificWidgets = {
  'Live': Text('Customized for Live', style: TextStyle(color: Colors.green)),
  'Store': Text('Customized for Store', style: TextStyle(color: Colors.blue)),
};
